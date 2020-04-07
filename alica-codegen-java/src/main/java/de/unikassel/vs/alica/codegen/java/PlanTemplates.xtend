package de.unikassel.vs.alica.codegen.java;

import de.unikassel.vs.alica.planDesigner.alicamodel.Plan;
import de.unikassel.vs.alica.planDesigner.alicamodel.Transition;
import org.apache.commons.lang3.StringUtils;


class PlanTemplates {

    def String constraints(Plan plan) '''

«IF (plan.relativeDirectory.isEmpty)»
    package de.uniks.vs.alica.code.gen.constraints;
«ELSE»
    package de.uniks.vs.alica.code.gen.«plan.relativeDirectory».constraints;
«ENDIF»

/*
 * Constraints - («StringUtils.capitalize(plan.name)»): «plan.id»
 */
public class «StringUtils.capitalize(plan.name)»«plan.id»Constraints {

}
'''

    def String constraintPlanPreCondition(Plan plan) '''
package de.uniks.vs.alica.code.gen;

import de.unikassel.vs.alica.engine.BasicConstraint;
import de.unikassel.vs.alica.engine.ProblemDescriptor;
import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.impl.Constraint«plan.preCondition.id»Impl;

/*
 * PreCondition («StringUtils.capitalize(plan.name)»:«plan.id»): «plan.preCondition.id»
 */
public class Constraint«plan.preCondition.id» extends BasicConstraint {
    private Constraint«plan.preCondition.id»Impl impl;

    public Constraint«plan.preCondition.id»() {
        super();
        impl = new Constraint«plan.preCondition.id»Impl();
    }

    public void getConstraint(ProblemDescriptor c, RunningPlan rp) {
«««        «IF (plan.preCondition !== null && plan.preCondition.pluginName == "DefaultPlugin")»
            impl.getConstraint(c, rp);
«««        «ENDIF»
    }
}
'''

def String constraintPlanPreConditionImpl(Plan plan) '''
package de.uniks.vs.alica.code.impl;

import de.unikassel.vs.alica.engine.ProblemDescriptor;
import de.uniks.vs.jalica.engine.RunningPlan;

/*
 * Plan PreCondition («StringUtils.capitalize(plan.name)»:«plan.id»): «plan.preCondition.id»
 */
public class Constraint«plan.preCondition.id»Impl {

    public Constraint«plan.preCondition.id»Impl() { }

    public void getConstraint(ProblemDescriptor c, RunningPlan rp) { }
}
'''

    def String constraintPlanRuntimeCondition(Plan plan) '''
package de.uniks.vs.alica.code.gen;

import de.unikassel.vs.alica.engine.BasicConstraint;
import de.unikassel.vs.alica.engine.ProblemDescriptor;
import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.impl.Constraint«plan.runtimeCondition.id»;

/*
 * Plan RuntimeCondition («StringUtils.capitalize(plan.name)»:«plan.id»): «plan.runtimeCondition.id»
 */
public class Constraint«plan.runtimeCondition.id» extends BasicConstraint {
    private Constraint«plan.runtimeCondition.id»Impl impl;

    public Constraint«plan.runtimeCondition.id»() {
        super();
        impl = new Constraint«plan.runtimeCondition.id»Impl();
    }

    public void getConstraint(ProblemDescriptor c, RunningPlan rp) {
«««        «IF (plan.runtimeCondition !== null && plan.runtimeCondition.pluginName == "DefaultPlugin")»
            impl.getConstraint(c, rp);
«««        «ENDIF»
    }
}
'''

def String constraintPlanRuntimeConditionImpl(Plan plan) '''
package de.uniks.vs.alica.code.impl;

import de.unikassel.vs.alica.engine.ProblemDescriptor;
import de.uniks.vs.jalica.engine.RunningPlan;

/*
 * Plan RuntimeCondition («StringUtils.capitalize(plan.name)»:«plan.id»): «plan.runtimeCondition.id»
 */
public class Constraint«plan.runtimeCondition.id»Impl {
    public Constraint«plan.runtimeCondition.id»Impl() {

    }

    public void getConstraint(ProblemDescriptor c, RunningPlan rp) {

    }
}
'''

    def String plan(Plan plan) '''
«IF (plan.relativeDirectory.isEmpty)»
    package de.uniks.vs.alica.code.gen;
«ELSE»
    package de.uniks.vs.alica.code.gen.«plan.relativeDirectory»;
«ENDIF»

import de.unikassel.vs.alica.engine.BasicPlan;
import de.unikassel.vs.alica.engine.BasicUtilityFunction;
import de.uniks.vs.alica.code.impl.«StringUtils.capitalize(plan.name)»«plan.id»Impl;

/*
 * Plan («StringUtils.capitalize(plan.name)» : «plan.id»)
 */
public class «StringUtils.capitalize(plan.name)»«plan.id» extends BasicPlan {
    private «StringUtils.capitalize(plan.name)»«plan.id»Impl impl;

    public «StringUtils.capitalize(plan.name)»«plan.id»() {
        impl = new «StringUtils.capitalize(plan.name)»«plan.id»Impl();
    }

    public BasicUtilityFunction getUtilityFunction(BasicPlan plan) {
        return impl.getUtilityFunction(plan);
    }
}
'''

    def String utilityFunctionPlan(Plan plan) '''
package de.uniks.vs.alica.code.gen.utilityfunctions;

import de.uniks.vs.jalica.engine.BasicUtilityFunction;
import de.uniks.vs.jalica.engine.UtilityFunction;
import de.uniks.vs.jalica.engine.model.Plan;

import de.uniks.vs.alica.code.impl.utilityfunctions.UtilityFunction«plan.id»Impl;

public class UtilityFunction«plan.id» extends BasicUtilityFunction {
    private UtilityFunction«plan.id»Impl impl;

    public UtilityFunction«plan.id»() {
        impl = new UtilityFunction«plan.id»Impl();
    }

    public UtilityFunction getUtilityFunction(Plan plan) {
        return impl.getUtilityFunction(plan);
    }
}
'''

    def String utilityFunctionPlanImpl(Plan plan) '''
package de.uniks.vs.alica.code.impl.utilityfunctions;

import de.uniks.vs.jalica.engine.DefaultUtilityFunction;
import de.uniks.vs.jalica.engine.UtilityFunction;
import de.uniks.vs.jalica.engine.model.Plan;

public class UtilityFunction«plan.id»Impl {
    public UtilityFunction«plan.id»Impl() {

    }

    public UtilityFunction getUtilityFunction(Plan plan) {
        return new DefaultUtilityFunction(plan);
    }
}
'''

    def String preConditionPlan(Plan plan) '''
package de.uniks.vs.alica.code.gen.conditions;

import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.gen.domain.DomainCondition;
import de.uniks.vs.alica.code.impl.conditions.PreCondition«plan.preCondition.id»Impl;

public class PreCondition«plan.preCondition.id» extends DomainCondition {

    static long id = «plan.preCondition.id»L;

    private PreCondition«plan.preCondition.id»Impl impl;

    public PreCondition«plan.preCondition.id»(Object context) {
        super(context);
        impl = new PreCondition«plan.preCondition.id»Impl(this);
    }

    public boolean evaluate(RunningPlan rp) {
        «IF (plan.preCondition !== null && plan.preCondition.pluginName == "DefaultPlugin")»
            return impl.evaluate(rp);
        «ELSE»
            return true;
        «ENDIF»
    }
}
'''

def String preConditionPlanImpl(Plan plan) '''
package de.uniks.vs.alica.code.impl;

import de.uniks.vs.jalica.engine.RunningPlan;

public class PreCondition«plan.preCondition.id»Impl {
    public PreCondition«plan.preCondition.id»Impl() {

    }

    public boolean evaluate(RunningPlan rp) {
        System.out.println("The PreCondition «plan.preCondition.id» in Plan «plan.getName» is not implement yet!");
        return false;
    }
}
'''

    def String runtimeConditionPlan(Plan plan) '''
package de.uniks.vs.alica.code.gen.conditions;

import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.gen.domain.DomainCondition;
import de.uniks.vs.alica.code.impl.RunTimeCondition«plan.runtimeCondition.id»Impl;

public class RunTimeCondition«plan.runtimeCondition.id» extends DomainCondition {
    static long id = «plan.runtimeCondition.id»L;

    private RunTimeCondition«plan.runtimeCondition.id»Impl impl;

    public RunTimeCondition«plan.runtimeCondition.id»(Object context) {
        super(context);
        impl = new RunTimeCondition«plan.runtimeCondition.id»Impl(this);
    }

    public boolean evaluate(RunningPlan rp) {
        «IF (plan.runtimeCondition !== null && plan.runtimeCondition.pluginName == "DefaultPlugin")»
            impl.evaluate(rp);
        «ELSE»
            return true;
        «ENDIF»
    }
}
'''

def String runtimeConditionPlanImpl(Plan plan) '''
package de.uniks.vs.alica.code.impl;

import de.uniks.vs.jalica.engine.RunningPlan;

public class RunTimeCondition«plan.runtimeCondition.id»Impl {
    public RunTimeCondition«plan.runtimeCondition.id»Impl() {

    }

    public boolean evaluate(RunningPlan rp) {
        return false;
    }
}
'''

def String transitionPreConditionPlanImpl(Transition transition) '''
package de.uniks.vs.alica.code.impl.conditions;

import de.uniks.vs.jalica.engine.RunningPlan;
import de.uniks.vs.alica.code.gen.domain.DomainCondition;

public class PreCondition«transition.preCondition.id»Impl {
    private DomainCondition condition;

    public PreCondition«transition.preCondition.id»Impl(DomainCondition condition) {
        this.condition = condition;
    }

    public boolean evaluate(RunningPlan rp) {
        System.out.println("The PreCondition «transition.preCondition.id» in Transition «transition.getName» is not implement yet!");
        return false;
    }
}
'''

    def String planImpl(Plan plan) '''
package de.uniks.vs.alica.code.impl;

import de.unikassel.vs.alica.engine.BasicPlan;
import de.unikassel.vs.alica.engine.BasicUtilityFunction;
import de.unikassel.vs.alica.engine.DefaultUtilityFunction;

public class «StringUtils.capitalize(plan.name)»«plan.id»Impl {
    public BasicUtilityFunction getUtilityFunction(BasicPlan plan) {
        return new DefaultUtilityFunction(plan);
    }
}
'''

}