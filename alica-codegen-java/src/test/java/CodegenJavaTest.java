import de.unikassel.vs.alica.codegen.CodegeneratorJava;
import de.unikassel.vs.alica.codegen.GeneratedSourcesManagerJava;
import de.unikassel.vs.alica.planDesigner.alicamodel.*;
import org.apache.commons.io.FileUtils;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.ClassRule;
import org.junit.Test;
import org.junit.rules.TemporaryFolder;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class CodegenJavaTest {
    private static String tmpPath;

    @ClassRule
    public static TemporaryFolder tmpFolder = new TemporaryFolder();

    @BeforeClass
    public static void beforeClass() {
        tmpPath = tmpFolder.getRoot().getAbsolutePath();
    }

    private void generateCode() throws IOException {
        // Generates java source code

        Plan plan = new Plan();
        plan.setMasterPlan(true);
        EntryPoint entryPoint = new EntryPoint();
        plan.addEntryPoint(entryPoint);
        State state = new State();
        TerminalState terminalState = new TerminalState();
        plan.addState(state);
        plan.addState(terminalState);
        Transition transition = new Transition();
        plan.addTransition(transition);
        plan.setDirty(false);
        plan.setRelativeDirectory("");
        plan.setId(1575724499793L);
        plan.setName("testfxPlan");

        List<Plan> plans = new ArrayList<>();
        plans.add(plan);

        Behaviour behaviour = new Behaviour();
        behaviour.setDirty(false);
        behaviour.setRelativeDirectory("");
        behaviour.setId(1575724510639L);
        behaviour.setName("testfxBehaviour");

        List<Behaviour> behaviours = new ArrayList<>();
        behaviours.add(behaviour);

        PreCondition preCondition = new PreCondition();
        preCondition.setEnabled(true);
        preCondition.setPluginName("DefaultPlugin");
        preCondition.setId(1575724578855L);
        preCondition.setName("Precondition1");
        plan.setPreCondition(preCondition);

        List<Condition> conditions = new ArrayList<>();
        conditions.add(preCondition);

        // generate code
        String genPath = tmpPath + File.separator + "src" + File.separator + "main" + File.separator + "java";
        GeneratedSourcesManagerJava generatedSourcesManager = new GeneratedSourcesManagerJava();
        generatedSourcesManager.setSourcePath(genPath);
        CodegeneratorJava codeGenerator = new CodegeneratorJava();
        codeGenerator.setPlans(plans);
        codeGenerator.setBehaviours(behaviours);
        codeGenerator.setConditions(conditions);
        codeGenerator.setDestination(genPath);
        codeGenerator.setGeneratedSourcesManager(generatedSourcesManager);
        codeGenerator.generate();

        // copy engine folder from resources to destination
        URL url = CodegenJavaTest.class.getResource("testProject");
        String path = url.getPath();
        File engineFolderSrc = new File(path);
        File engineFolderDst = new File(tmpPath);
        FileUtils.copyDirectory(engineFolderSrc, engineFolderDst);
    }

    private int cleanInstallProject() throws IOException, InterruptedException {
        // run compilation
        ProcessBuilder builder = new ProcessBuilder("mvn", "clean", "install");
        builder.directory(new File(tmpPath).getAbsoluteFile());  // set current working directory for process
        builder.redirectErrorStream(true);
        Process process = builder.start();

        // output stdout and stderr
        BufferedReader stdout = new BufferedReader(new InputStreamReader(process.getInputStream()));
        BufferedReader stderr = new BufferedReader(new InputStreamReader(process.getErrorStream()));
        String s;
        while ((s = stdout.readLine()) != null) {
            System.out.println(s);
        }
        while ((s = stderr.readLine()) != null) {
            System.out.println(s);
        }

        // output exit code
        int exitCode = process.waitFor();
        System.out.println("Exit code: " + exitCode);

        return exitCode;
    }

    @Test
    public void testGeneratedCode() throws Exception {
        generateCode();

        // mvn clean install:
        // success -> exit code 0
        // fail -> exit code 1
        int exitCode = cleanInstallProject();
        Assert.assertEquals(0, exitCode);
    }
}
