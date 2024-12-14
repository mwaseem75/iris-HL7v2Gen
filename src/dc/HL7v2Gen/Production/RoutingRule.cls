/// 
Class dc.HL7v2Gen.Production.RoutingRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.HL7.MsgRouter.RoutingEngine" production="dc.HL7v2Gen.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="">
<constraint name="source" value="HL7FileService"></constraint>
<when condition="1" comment="">
<send transform="" target="HL7FileOperation"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
