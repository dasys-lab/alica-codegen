package de.unikassel.vs.alica.codegen;

import de.unikassel.vs.alica.planDesigner.alicamodel.AbstractPlan;
import de.unikassel.vs.alica.planDesigner.alicamodel.Behaviour;
import org.apache.commons.lang3.StringUtils;

import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class GeneratedSourcesManagerJava extends GeneratedSourcesManager {

    @Override
    public String getSourcePath() {
        return Paths.get(sourcePath, "de", "uniks", "vs", "alica", "code").toString();
    }

    public List<File> getGeneratedFilesForBehaviour(Behaviour behaviour) {
        List<File> generatedFiles = new ArrayList<>();
        String path = trimFileFromPath(behaviour.getRelativeDirectory());
        String filename = StringUtils.capitalize(behaviour.getName()) + ".java";
        generatedFiles.add(Paths.get(getSourcePath(), path, filename).toFile());
        return generatedFiles;
    }

    public List<File> getGeneratedConditionFilesForPlan(AbstractPlan abstractPlan) {
        List<File> generatedFiles = new ArrayList<>();
        String path = trimFileFromPath(abstractPlan.getRelativeDirectory());
        String filename = StringUtils.capitalize(abstractPlan.getName()) + abstractPlan.getId() + ".java";
        generatedFiles.add(Paths.get(getSourcePath(), path, filename).toFile());
        return generatedFiles;
    }

    public List<File> getGeneratedConstraintFilesForPlan(AbstractPlan abstractPlan) {
        List<File> generatedFiles = new ArrayList<>();
        String path = trimFileFromPath(abstractPlan.getRelativeDirectory());
        String filename = StringUtils.capitalize(abstractPlan.getName()) + abstractPlan.getId() + "Constraints.java";
        generatedFiles.add(Paths.get(getSourcePath(), path, "constraints", filename).toFile());
        return generatedFiles;
    }

    public List<File> getGeneratedConstraintFilesForBehaviour(Behaviour behaviour) {
        List<File> generatedFiles = new ArrayList<>();
        String path = trimFileFromPath(behaviour.getRelativeDirectory());
        String filename = StringUtils.capitalize(behaviour.getName()) + behaviour.getId() + "Constraints.java";
        generatedFiles.add(Paths.get(getSourcePath(), path, "constraints", filename).toFile());
        return generatedFiles;
    }
}
