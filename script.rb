require 'yaml'
require 'salesforce_bulk'

credentials = YAML.load_file("credentials.yml")
DATA_FILE = "#{credentials['source']['username'].split('.').last}.yml"

if ARGV[0] == 'fetch' then
  salesforce = SalesforceBulk::Api.new(credentials['source']['username'], credentials['source']['password'], credentials['source']['test'])
  puts "------- Authentication Completed -----------"

  results = []
  object_hash = [{Name: 'Q2O_Custom_Settings__c', Fields: ['Name', 'Value__c']},
                 {Name: 'Apttus_Approval__ApprovalsCustomConfig__c', Fields: ['Name',
                                                                              'Apttus_Approval__ApprovalGroupStatusField__c',
                                                                              'Apttus_Approval__ApprovalStatusField__c',
                                                                              'Apttus_Approval__ApprovalSummaryPage__c',
                                                                              'Apttus_Approval__AssignmentEmailTemplate__c',
                                                                              'Apttus_Approval__BackupAdminUser__c',
                                                                              'Apttus_Approval__CancellationEmailTemplate__c',
                                                                              'Apttus_Approval__EscalationEmailTemplate__c',
                                                                              'Apttus_Approval__NotifyOnlyEmailTemplate__c',
                                                                              'Apttus_Approval__ReassignmentEmailTemplate__c']},
                 {Name: 'Apttus_Approval__ApprovalsSystemProperties__c', Fields: ['Name',
                                                                                  'Apttus_Approval__ApprovalTaskPrefix__c',
                                                                                  'Apttus_Approval__BackupAdminProfile__c',
                                                                                  'Apttus_Approval__BackupAdminUser__c',
                                                                                  'Apttus_Approval__BackupFilterPage__c',
                                                                                  'Apttus_CQApprov__CartApprovalContextType__c',
                                                                                  'Apttus_Approval__EmailApprovalServiceAddress__c',
                                                                                  'Apttus_Approval__EmailSenderDisplayName__c',
                                                                                  'Apttus_Approval__EnableApprovalRequestAutoEscalation__c',
                                                                                  'Apttus_Approval__EnableEmailApprovalResponse__c',
                                                                                  'Apttus_Approval__InstanceUrl__c',
                                                                                  'Apttus_Approval__ReassignFilterPage__c',
                                                                                  'Apttus_Approval__UIAssigneeSearchPageSize__c',
                                                                                  'Apttus_Approval__UICustomAssigneeObjectTypes__c']},
                 {Name: 'Apttus__ComplyCustomClasses__c', Fields: ['Name',
                                                                   'Apttus__DynamicSectionCallbackClass__c',
                                                                   'Apttus__LifecycleCallbackClass__c']},
                 {Name: 'Apttus__ComplySystemProperties__c', Fields: ['Name',
                                                                      'Apttus__AdminUser__c',
                                                                      'Apttus_CMConfig__AutoSyncWithOpportunity__c',
                                                                      'Apttus__BypassSharing__c',
                                                                      'Apttus__ContractSummaryTemplate__c',
                                                                      'Apttus__DefaultOpportunityAgreementOwner__c',
                                                                      'Apttus__EmailTemplateForCheckinNotification__c',
                                                                      'Apttus__EnableMultipleCheckout__c',
                                                                      'Apttus__EnablePDFSecurity__c',
                                                                      'Apttus__EnableSubmitMergeCall__c',
                                                                      'Apttus__EnableVersionControl__c',
                                                                      'Apttus__InstanceUrl__c',
                                                                      'Apttus__MaxChildLevel__c',
                                                                      'Apttus__MergeCallTimeoutMillis__c',
                                                                      'Apttus__MergeWebserviceEndpoint__c',
                                                                      'Apttus__PDFOwnerPwd__c',
                                                                      'Apttus__PublishMergeEvents__c',
                                                                      'Apttus_CMConfig__SyncBundleUsingLineItems__c',
                                                                      'Apttus_CMConfig__SyncOptionProducts__c']},
                 {Name: 'Apttus_Config2__ConfigConstraintCriteriaFields__c', Fields: ['Name',
                                                                                      'Apttus_Config2__FieldName__c']},
                 {Name: 'Apttus_Config2__ConfigCustomClasses__c', Fields: ['Name',
                                                                           'Apttus_Config2__ActionInvokerCallbackClass__c',
                                                                           'Apttus_Config2__ActionParamsCallbackClass__c',
                                                                           'Apttus_Config2__AdjustmentLineItemCallbackClass__c',
                                                                           'Apttus_Config2__AdvancedApprovalCallbackClass__c',
                                                                           'Apttus_Config2__AssetLineItemCallbackClass__c',
                                                                           'Apttus_Config2__CartApprovalCallbackClass__c',
                                                                           'Apttus_Config2__DealOptimizerCallbackClass__c',
                                                                           'Apttus_Config2__FormulaCallbackClass__c',
                                                                           'Apttus_Config2__PricingCallbackClass__c',
                                                                           'Apttus_Config2__ProductAttributeCallbackClass__c',
                                                                           'Apttus_Config2__RelatedPricingCallbackClass__c',
                                                                           'Apttus_Config2__ValidationCallbackClass__c']},
                 {Name: 'Apttus_Config2__ConfigCustomDisplayActions__c', Fields: ['Name',
                                                                                  'Apttus_Config2__ActionLabelName__c',
                                                                                  'Apttus_Config2__ActionName__c',
                                                                                  'Apttus_Config2__ActionPage__c',
                                                                                  'Apttus_Config2__ActionParams__c',
                                                                                  'Apttus_Config2__ActionType__c',
                                                                                  'Apttus_Config2__Behavior__c',
                                                                                  'Apttus_Config2__DisplayType__c',
                                                                                  'Apttus_Config2__IsEnabled__c',
                                                                                  'Apttus_Config2__Sequence__c']},
                 {Name: 'Apttus_Config2__ConfigCustomDisplayColumns__c', Fields: ['Name',
                                                                                  'Apttus_Config2__DisplayType__c',
                                                                                  'Apttus_Config2__FieldName__c',
                                                                                  'Apttus_Config2__HeaderStyle__c',
                                                                                  'Apttus_Config2__IsEditable__c',
                                                                                  'Apttus_Config2__IsSortable__c',
                                                                                  'Apttus_Config2__Sequence__c',
                                                                                  'Apttus_Config2__Style__c',
                                                                                  'Apttus_Config2__StyleClass__c']},
                 {Name: 'Apttus_Config2__ConfigHeaderCriteriaFields__c', Fields: ['Name',
                                                                                  'Apttus_Config2__CriteriaFieldNames__c']},
                 {Name: 'Apttus_Config2__ConfigLineItemCriteriaFields__c', Fields: ['Name',
                                                                                    'Apttus_Config2__CriteriaFieldNames__c']},
                 {Name: 'Apttus_Config2__ConfigSelectBundleOptionsSettings__c', Fields: ['Name',
                                                                                         'Apttus_Config2__BundleDescriptionField__c',
                                                                                         'Apttus_Config2__HidePriceColumn__c',
                                                                                         'Apttus_Config2__HideValidateButton__c',
                                                                                         'Apttus_Config2__ListedOptionsColumn2__c',
                                                                                         'Apttus_Config2__ListedOptionsColumn3__c',
                                                                                         'Apttus_Config2__MainSectionRatio__c',
                                                                                         'Apttus_Config2__ShowBundleDetail__c',
                                                                                         'Apttus_Config2__ShowOptionQuantity__c']},
                 {Name: 'Apttus_Config2__ConfigSelectConfigProductsSettings__c', Fields: ['Name',
                                                                                          'Apttus_Config2__CarouselCategoryLevel__c',
                                                                                          'Apttus_Config2__CarouselDefaultIcon__c',
                                                                                          'Apttus_Config2__CartListItemDescriptionField__c',
                                                                                          'Apttus_Config2__CollapseAllLeafOptionGroups__c',
                                                                                          'Apttus_Config2__CustomActionLabelName__c',
                                                                                          'Apttus_Config2__CustomActionPage__c',
                                                                                          'Apttus_Config2__EnableCategoryFilter__c',
                                                                                          'Apttus_Config2__HideBreadcrumb__c',
                                                                                          'Apttus_Config2__HideCartHeader__c',
                                                                                          'Apttus_Config2__HideCompareProducts__c',
                                                                                          'Apttus_Config2__HideConfigureAction__c',
                                                                                          'Apttus_Config2__HideDefaultOptionsInDescription__c',
                                                                                          'Apttus_Config2__HideHelpMeChoose__c',
                                                                                          'Apttus_Config2__HideLineItemAttributeDetails__c',
                                                                                          'Apttus_Config2__HideListedProductsPriceColumn__c',
                                                                                          'Apttus_Config2__HideNarrowYourSearch__c',
                                                                                          'Apttus_Config2__HideProductImage__c',
                                                                                          'Apttus_Config2__HideSelectedProductChargeTypes__c',
                                                                                          'Apttus_Config2__HideSelectedProductsColumn1__c',
                                                                                          'Apttus_Config2__ListedProductsColumn2__c',
                                                                                          'Apttus_Config2__ListedProductsColumn3__c',
                                                                                          'Apttus_Config2__ListedProductsDefaultIcon__c',
                                                                                          'Apttus_Config2__MainSectionRatio__c',
                                                                                          'Apttus_Config2__OrderStatusFields__c',
                                                                                          'Apttus_Config2__ReadOnlyLocation__c',
                                                                                          'Apttus_Config2__SearchQueryLimit__c',
                                                                                          'Apttus_Config2__SelectedProductsColumn2__c',
                                                                                          'Apttus_Config2__SelectedProductsColumn3__c',
                                                                                          'Apttus_Config2__SelectedProductsColumn4__c',
                                                                                          'Apttus_Config2__ShowCartIcon__c',
                                                                                          'Apttus_Config2__ShowProductIconCartDetailView__c',
                                                                                          'Apttus_Config2__ShowRecommendedProductsCartView__c',
                                                                                          'Apttus_Config2__ShowSelectedProductAllCharges__c',
                                                                                          'Apttus_Config2__ShowSelectedProductsInConfigOptions__c',
                                                                                          'Apttus_Config2__TwoColumnAttributeDisplay__c']},
                 {Name: 'Apttus_Proposal__ProposalSystemProperties__c', Fields: ['Name','Apttus_Proposal__AdminUser__c', 'Apttus_QPConfig__AutoSyncWithOpportunity__c', 'Apttus_Proposal__BypassSharing__c', 'Apttus_Proposal__DefaultOpportunityQuoteOwner__c']},
                 {Name: 'Apttus_Proposal__ProposalCustomClasses__c', Fields: ['Name','Apttus_Proposal__LifecycleCallbackClass__c']},
                 {Name: 'Apttus_Config2__InstalledProductsSettings__c', Fields: ['Name','Apttus_Config2__AmendChangeFields__c', 'Apttus_Config2__DefaultRenewalTerm__c', 'Apttus_Config2__FilterFields__c', 'Apttus_Config2__MaxRenewsPerTrip__c','Apttus_Config2__ShowAccountsFilter__c']},
                 {Name: 'FrequencyCustomSetting__c', Fields: ['Name','Value__c']},
                 {Name: 'Apttus_DealMgr__DealManagerSystemProperties__c', Fields: ['Name','Apttus_DealMgr__DealGuidanceCallbackClass__c', 'Apttus_DealMgr__DealOptimizerCallbackClass__c']},
                 {Name: 'Apttus_Config2__ConfigUserPreferences__c', Fields: ['Name', 'SetupOwnerId', 'Apttus_Config2__CategoryPreference__c', 'Apttus_Config2__CollapseErrorMessage__c', 'Apttus_Config2__CollapseInfoMessage__c', 'Apttus_Config2__CollapseQuickAddFilter__c','Apttus_Config2__CollapseWarningMessage__c','Apttus_Config2__ItemsPerPage__c','Apttus_Config2__OptionItemsPerPage__c','Apttus_Config2__SelectedComparisonProducts__c','Apttus_Config2__SelectedProductsPerPage__c']},
                 {Name: 'Apttus_Config2__ConfigSystemProperties__c', Fields: ['Name','Apttus_Config2__ActionsColumnPosition__c', 'Apttus_Config2__AdminUser__c', 'Apttus_Config2__AutoFinalizeOnCartApproval__c', 'Apttus_Config2__AutoSyncOnCartApproval__c','Apttus_Config2__BaseProductRelationField__c','Apttus_Config2__BypassSharing__c','Apttus_Config2__BypassShoppingCart__c','Apttus_Config2__CascadeSharedAttributeUpdates__c','Apttus_Config2__CurrencyFieldPrecision__c','Apttus_Config2__CustomAssetActionLabelName__c','Apttus_Config2__CustomAssetActionPage__c','Apttus_Config2__DefaultProductsPage__c','Apttus_Config2__AlertSelectedExclude__c','Apttus_Config2__DeferPricingUntilCart__c','Apttus_Config2__DeferValidationCheckInBundles__c','Apttus_Config2__DirectConfigureAssetActions__c','Apttus_Config2__DisableChargeTypeTotaling__c','Apttus_Config2__DisableConstraintRules__c','Apttus_Config2__DisableExistingAssetPricing__c','Apttus_Config2__EnableAggregatePricing__c','Apttus_Config2__EnableAutoReprice__c','Apttus_Config2__EnableAutoSequencingForOptions__c','Apttus_Config2__EnableDefaultingForOptions__c','Apttus_Config2__EnableDefaultingForProducts__c','Apttus_Config2__EnableExternalPricing__c','Apttus_Config2__EnableLocation__c','Apttus_Config2__EnableMatrixPricingForOptions__c','Apttus_Config2__GuidePageDefault__c','Apttus_Config2__HideAssetActions__c','Apttus_Config2__HideCopyAction__c','Apttus_Config2__HideGrandTotal__c','Apttus_Config2__HideResolveConfigLink__c','Apttus_Config2__HideSubtotalsInCart__c','Apttus_Config2__IndicateErrorTypeExclude__c','Apttus_Config2__IndicateWarningTypeExclude__c','Apttus_Config2__InstanceUrl__c','Apttus_Config2__KeepAbandonedCarts__c','Apttus_Config2__MaxAdjustmentLines__c','Apttus_Config2__MaxConstraintRulesRoundTrip__c','Apttus_Config2__MiscChargeTypes__c','Apttus_Config2__OptionLineItemColumns__c','Apttus_Config2__OptionProductColumns__c','Apttus_Config2__OptionsPageDefault__c','Apttus_Config2__PercentageFieldPrecision__c','Apttus_Config2__PreventErrorTypeExcludeSelection__c','Apttus_Config2__ProductAttributeDetailPage__c','Apttus_Config2__ProductTotalingHierarchy__c','Apttus_Config2__QuantityFieldPrecision__c','Apttus_Config2__ResolveConfigurationPageDefault__c','Apttus_Config2__RunFinalizationTaskInAsyncMode__c','Apttus_Config2__SearchAttributeDefaultPage__c','Apttus_Config2__SearchAttributeValuePage__c','Apttus_Config2__SearchCategoryDefault__c','Apttus_Config2__ShowErrorInHeader__c','Apttus_Config2__ShowHeader__c','Apttus_Config2__ShowInfoInHeader__c','Apttus_Config2__ShowMessageInline__c','Apttus_Config2__AlertInclude__c','Apttus_Config2__TabViewInConfigureBundle__c','Apttus_Config2__ShowWarningInHeader__c','Apttus_Config2__SkipPricingOnSelectPages__c','Apttus_Config2__SkipReview__c','Apttus_Config2__StaticCriteriaFields__c','Apttus_Config2__TotalingGroupType__c','Apttus_Config2__ViewCartCustomFields__c','Apttus_Config2__ViewCartCustomFields2__c','Apttus_Config2__ViewCartPage__c','Apttus_Config2__ViewCartTotalCustomFields__c']}
  ]
  object_hash.each do |hash|

    puts "Fetching #{hash[:Name]}"
    result = salesforce.query(hash[:Name], "select #{hash[:Fields].join(', ')} from #{hash[:Name]}").result
    results << {hash[:Name] => result.records.collect(&:to_hash)}
    puts "Failed to fetch #{hash[:Name]}" unless result.success
  end

  File.open(DATA_FILE, 'w') {|f| f.write results.to_yaml } #Store
  puts "------- Completed -----------"

elsif ARGV[0] == 'load'
  salesforce = SalesforceBulk::Api.new(credentials['destination']['username'], credentials['destination']['password'], credentials['destination']['test'])
  puts "------- Authentication Completed -----------"

  puts "------- Loading started -----------"
  @data = YAML.load_file(DATA_FILE)
  @data.each do |item|
    item.each do |k, v|
      puts "Loading #{k}"
      salesforce.create(k, v) if v.size > 0
      puts "Loading completed #{k}"
    end
  end
  puts "------- Loading completed -----------"
else
  raise 'Please pass the action.'
end


