package de.unikassel.vs.alica.codegen.java.templates;

import de.unikassel.vs.alica.planDesigner.alicamodel.Behaviour;
import org.apache.commons.lang3.StringUtils;
import de.unikassel.vs.alica.codegen.templates.IBehaviourTemplates;


class BehaviourTemplates implements IBehaviourTemplates {

    override String behaviour(Behaviour behaviour) '''
«IF (behaviour.relativeDirectory.isEmpty)»
    package de.uniks.vs.alica.code.gen.behaviours;
«ELSE»
    package de.uniks.vs.alica.code.gen.behaviours.«behaviour.relativeDirectory»;
«ENDIF»

import de.uniks.vs.alica.code.gen.domain.DomainBehaviour;
import de.uniks.vs.alica.code.impl.behaviours.«StringUtils.capitalize(behaviour.name)»Impl;

public class «StringUtils.capitalize(behaviour.name)» extends DomainBehaviour {
    public «StringUtils.capitalize(behaviour.name)»(Object context) {
        super("«behaviour.name»", «behaviour.id»L, context);
        this.impl = new «StringUtils.capitalize(behaviour.name)»Impl(this);
    }

    @Override
    public void run() {

    }

    public void run(Object msg) {
        this.impl.run(msg);
    }

    public void initialiseParameters() {
        this.impl.initialiseParameters();
    }
}
'''

    override String behaviourImpl(Behaviour behaviour) '''
package de.uniks.vs.alica.code.impl.behaviours;

import de.uniks.vs.alica.code.gen.domain.DomainBehaviour;
import de.uniks.vs.alica.code.impl.domain.DomainBehaviourImpl;

public class «StringUtils.capitalize(behaviour.name)»Impl extends DomainBehaviourImpl {
    public «StringUtils.capitalize(behaviour.name)»Impl(DomainBehaviour domain) {
        super(domain);
    }

    public void run(Object msg) {
        System.out.println("Behaviour «StringUtils.capitalize(behaviour.name)»(" + this.domain.getOwnId() + "): started");
    }

    public void initialiseParameters() {

    }
}
'''

    override String behaviourCondition(Behaviour behaviour) '''
«IF (behaviour.relativeDirectory.isEmpty)»
    package de.uniks.vs.alica.code.gen.behaviours;
«ELSE»
    package de.uniks.vs.alica.code.gen.behaviours.«behaviour.relativeDirectory»;
«ENDIF»

public class «StringUtils.capitalize(behaviour.name)»«behaviour.id» {
    static long id = «behaviour.id»L;
}
'''

    override String preConditionBehaviour(Behaviour behaviour) '''
package de.uniks.vs.alica.code.gen.conditions;

import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.gen.domain.DomainCondition;
import de.uniks.vs.alica.code.impl.conditions.PreCondition«behaviour.preCondition.id»Impl;

public class PreCondition«behaviour.preCondition.id» extends DomainCondition {
    static long id = «behaviour.preCondition.id»L;

    private PreCondition«behaviour.preCondition.id»Impl impl;

    public PreCondition«behaviour.preCondition.id»(Object context) {
        super(context);
        this.impl = new PreCondition«behaviour.preCondition.id»Impl();
    }

    public boolean evaluate(RunningPlan rp) {
        return this.impl.evaluate(rp);
    }
}
'''

    override String preConditionBehaviourImpl(Behaviour behaviour) '''
package de.uniks.vs.alica.code.impl.conditions;

import de.uniks.vs.jalica.engine.RunningPlan;

public class PreCondition«behaviour.preCondition.id»Impl {
    static long id = «behaviour.preCondition.id»L;

    public PreCondition«behaviour.preCondition.id»Impl() {

    }

    public boolean evaluate(RunningPlan rp) {
        System.out.println("The PreCondition " + id + " is not implement yet!");
        return false;
    }
}
'''

    override String runtimeConditionBehaviour(Behaviour behaviour) '''
package de.uniks.vs.alica.code.gen.conditions;

import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.gen.domain.DomainCondition;
import de.uniks.vs.alica.code.impl.conditions.RunTimeCondition«behaviour.runtimeCondition.id»Impl;

public class RunTimeCondition«behaviour.runtimeCondition.id» extends DomainCondition {
    static long id = «behaviour.runtimeCondition.id»L;

    private RunTimeCondition«behaviour.runtimeCondition.id»Impl impl;

    public RunTimeCondition«behaviour.runtimeCondition.id»(Object context) {
        super(context);
        this.impl = new PostCondition«behaviour.postCondition.id»Impl();
    }

    public boolean evaluate(RunningPlan rp) {
        return this.impl.evaluate(rp);
    }
}
'''

    override String runtimeConditionBehaviourImpl(Behaviour behaviour) '''
package de.uniks.vs.alica.code.impl.conditions;

import de.uniks.vs.jalica.engine.RunningPlan;

public class RunTimeCondition«behaviour.runtimeCondition.id»Impl {
    static long id = «behaviour.runtimeCondition.id»L;

    public RunTimeCondition«behaviour.runtimeCondition.id»Impl() {

    }

    public boolean evaluate(RunningPlan rp) {
        return false;
    }
}
'''

    override String postConditionBehaviour(Behaviour behaviour) '''
package de.uniks.vs.alica.code.gen.conditions;

import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.gen.domain.DomainCondition;
import de.uniks.vs.alica.code.impl.conditions.PostCondition«behaviour.postCondition.id»Impl;

public class PostCondition«behaviour.postCondition.id» extends DomainCondition {
    static long id = «behaviour.postCondition.id»L;

    private PostCondition«behaviour.postCondition.id»Impl impl;

    public PostCondition«behaviour.postCondition.id»(Object context) {
        super(context);
        this.impl = new PostCondition«behaviour.postCondition.id»Impl();
    }

    public boolean evaluate(RunningPlan rp) {
        return this.impl.evaluate(rp);
    }
}
'''

    override String postConditionBehaviourImpl(Behaviour behaviour) '''
package de.uniks.vs.alica.code.impl.conditions;

import de.uniks.vs.jalica.engine.RunningPlan;

public class PostCondition«behaviour.postCondition.id»Impl {
    static long id = «behaviour.postCondition.id»L;

    public PostCondition«behaviour.postCondition.id»Impl() {

    }

    public boolean evaluate(RunningPlan rp) {
        return false;
    }
}
'''

    override String constraints(Behaviour behaviour) '''
«IF (behaviour.relativeDirectory.isEmpty)»
    package de.uniks.vs.alica.code.gen.constraints;
«ELSE»
    package de.uniks.vs.alica.code.gen.«behaviour.relativeDirectory».constraints;
«ENDIF»

public class «StringUtils.capitalize(behaviour.name)»«behaviour.id»Constraints {
    static long id = «behaviour.id»L;
}
'''

    override String constraintPreCondition(Behaviour behaviour) '''
package de.uniks.vs.alica.code.gen.constraints;

import de.uniks.vs.jalica.engine.BasicConstraint;
import de.uniks.vs.jalica.engine.ProblemDescriptor;
import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.impl.constraints.Constraint«behaviour.preCondition.id»Impl;

public class Constraint«behaviour.preCondition.id» extends BasicConstraint {
    static long id = «behaviour.preCondition.id»L;

    private Constraint«behaviour.preCondition.id»Impl impl;

    public Constraint«behaviour.preCondition.id»() {
        super();
        this.impl = new Constraint«behaviour.preCondition.id»Impl();
    }

    public void getConstraint(ProblemDescriptor c, RunningPlan rp) {
        this.impl.getConstraint(c, rp);
    }
}
'''

    override String constraintPreConditionImpl(Behaviour behaviour) '''
package de.uniks.vs.alica.code.impl.constraints;

import de.uniks.vs.jalica.engine.ProblemDescriptor;
import de.uniks.vs.jalica.engine.RunningPlan;

public class Constraint«behaviour.preCondition.id»Impl {
    static long id = «behaviour.preCondition.id»L;

    public Constraint«behaviour.preCondition.id»Impl() {

    }

    public void getConstraint(ProblemDescriptor c, RunningPlan rp) {

    }
}
'''

    override String constraintRuntimeCondition(Behaviour behaviour) '''
package de.uniks.vs.alica.code.gen.constraints;

import de.uniks.vs.jalica.engine.BasicConstraint;
import de.uniks.vs.jalica.engine.ProblemDescriptor;
import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.impl.constraints.Constraint«behaviour.runtimeCondition.id»Impl;

public class Constraint«behaviour.runtimeCondition.id» extends BasicConstraint {
    static long id = «behaviour.runtimeCondition.id»L;

    private Constraint«behaviour.runtimeCondition.id»Impl impl;

    public Constraint«behaviour.runtimeCondition.id»() {
        super();
        this.impl = new Constraint«behaviour.runtimeCondition.id»Impl();
    }

    public void getConstraint(ProblemDescriptor c, RunningPlan rp) {
        this.impl.getConstraint(c, rp);
    }
}
'''

    override String constraintRuntimeConditionImpl(Behaviour behaviour) '''
package de.uniks.vs.alica.code.impl.constraints;

import de.uniks.vs.jalica.engine.ProblemDescriptor;
import de.uniks.vs.jalica.engine.RunningPlan;

public class Constraint«behaviour.runtimeCondition.id»Impl {
    static long id = «behaviour.runtimeCondition.id»L;

    public Constraint«behaviour.runtimeCondition.id»Impl() {

    }

    public void getConstraint(ProblemDescriptor c, RunningPlan rp) {

    }
}
'''

    override String constraintPostCondition(Behaviour behaviour) '''
package de.uniks.vs.alica.code.gen.constraints;

import de.uniks.vs.jalica.engine.BasicConstraint;
import de.uniks.vs.jalica.engine.ProblemDescriptor;
import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.impl.constraints.Constraint«behaviour.postCondition.id»Impl;

public class Constraint«behaviour.postCondition.id» extends BasicConstraint {
    static long id = «behaviour.postCondition.id»L;

    private Constraint«behaviour.postCondition.id»Impl impl;

    public Constraint«behaviour.postCondition.id»() {
        super();
        this.impl = new Constraint«behaviour.postCondition.id»Impl();
    }

    public void getConstraint(ProblemDescriptor c, RunningPlan rp) {
        this.impl.getConstraint(c, rp);
    }
}
'''

    override String constraintPostConditionImpl(Behaviour behaviour) '''
package de.uniks.vs.alica.code.impl.constraints;

import de.uniks.vs.jalica.engine.ProblemDescriptor;
import de.uniks.vs.jalica.engine.RunningPlan;

public class Constraint«behaviour.postCondition.id»Impl {
    static long id = «behaviour.postCondition.id»L;

    public Constraint«behaviour.postCondition.id»Impl() {

    }

    public void getConstraint(ProblemDescriptor c, RunningPlan rp) {

    }
}
'''

}
