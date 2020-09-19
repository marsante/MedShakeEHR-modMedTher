-- Mise à jour n° de version
UPDATE `system` SET `value`='v0.0.4' WHERE `name`='medtherm' and `groupe`='module';

-- Ajout nouveau datatype pour la préscription de soins
SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='medtheCatPresSoins');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'medtheDoucheGenJetPreciAvecBaveuse', '', 'Avec Baveuse', '', '', '', 'checkbox', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '58'),
('medical', 'medthePresSoinsMassageSsEauKineAutresSiPasDispo', 'Autres soins si pas dispo', 'Autres soins si pas dispo', '', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '131');

-- Ajout de nouveau datatype pour courrier au mt
SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='medtheCatCourrierMT');
INSERT IGNORE INTO `data_types` (`groupe`, `name`, `placeholder`, `label`, `description`, `validationRules`, `validationErrorMsg`, `formType`, `formValues`, `module`, `cat`, `fromID`, `creationDate`, `durationLife`, `displayOrder`) VALUES
('medical', 'medtheCouMtImcFinal', '', 'IMC Final', 'IMC à la dérnière consultation thérmal', '', '', 'text', '', 'base', @catID, '1', '2019-01-01 00:00:00', '3600', '10'),
('medical', 'medtheCouMtImcInitial', '', 'IMC Initial', 'IMC de la première consulation thérmal', '', '', 'text', '', 'medtherm', @catID, '1', '2019-01-01 00:00:00', '3600', '10');

-- Mise à jour du formulaire de préscription de soins
UPDATE `forms` SET  `yamlStructure`='global:\r\n  formCss: > \r\n    .colFormSoinsFixWidth {\r\n      flex: 0 0 70px;\r\n    }\r\nstructure:\r\n  row1:\r\n    head: \"Prescription des soins\"\r\n    col1:\r\n      size: col-3\r\n      bloc: \r\n        - medthePresSoinsOrient1                   		#1034 1re orientation\n    col2:\r\n      size: col-3\r\n      bloc: \r\n        - medthePresSoinsOrient2                   		#1035 2e orientation\n    col3:\r\n      size: col-3\r\n      bloc: \r\n        - medthePresSoinsLimitSoins                		#1023 Limitation des soins\n        - medthePresSoinsElevateur                 		#1003 Élévateur\n\r\n    col4:\r\n      size: col-3\r\n      class: text-right\r\n      bloc: \r\n        - label{<button class=\"btn btn-sm btn-secondary clearForm\" title=\"Rendre vierge\"><i class=\"fas fa-trash\"></i></button>}		\n\r\n  row2:\r\n    class: border-bottom py-1 mt-4\r\n    col1:\r\n      size: col-3\r\n      class:\r\n      bloc:\r\n        - label{ }                                		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{PHL1}                             		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{PHL3}                             		\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{GYN}                              		\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{RH1}                              		\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{RH3}                              		\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{NB}                               		\n\r\n  row3:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Piscine}                          		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsPiscinePhl3,nolabel       		#1037 PiscinePhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsPiscineRh1,nolabel        		#1039 PiscineRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsPiscineRh3,nolabel        		#1040 PiscineRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsPiscineNbSoins,nolabel    		#1036 PiscineNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsPiscinePreci,nolabel      		#1038 PiscinePreci\n\r\n  row4:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Bain}                             		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainPhl1,nolabel          		#941  BainPhl1\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainPhl3,nolabel          		#942  BainPhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainGyn,nolabel           		#935  BainGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainRh1,nolabel           		#945  BainRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainRh3,nolabel           		#946  BainRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainNbSoins,nolabel       		#940  BainNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsBainPreciT,nolabel,plus={°C} 		#943  BainPreciT\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsBainPreciTemps,nolabel    		#944  BainPreciTemps\n\r\n  row5:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Bain local des mains}             		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainLocalMainsRh1,nolabel 		#938  BainLocalMainsRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainLocalMainsRh3,nolabel 		#939  BainLocalMainsRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainLocalMainsNbSoins,nolabel 		#936  BainLocalMainsNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsBainLocalMainsPreci,nolabel 		#937  BainLocalMainsPreci\n\r\n  row6:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Bain avec aérobain}              		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainAerobainPhl1,nolabel  		#912  BainAerobainPhl1\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainAerobainPhl3,nolabel  		#913  BainAerobainPhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainAerobainGyn,nolabel   		#910  BainAerobainGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainAerobainRh1,nolabel   		#916  BainAerobainRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainAerobainRh3,nolabel   		#917  BainAerobainRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainAerobainNbSoins,nolabel 		#911  BainAerobainNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsBainAerobainPreciT,nolabel,plus={°C} 		#914  BainAerobainPreciT\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsBainAerobainPreciTemps,nolabel 		#915  BainAerobainPreciTemps\n\r\n  row7:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Bain avec douche en immersion}    		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheImmerPhl1,nolabel 		#920  BainDoucheImmerPhl1\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheImmerPhl3,nolabel 		#921  BainDoucheImmerPhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheImmerGyn,nolabel 		#918  BainDoucheImmerGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheImmerRh1,nolabel 		#926  BainDoucheImmerRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheImmerRh3,nolabel 		#927  BainDoucheImmerRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheImmerNbSoins,nolabel 		#919  BainDoucheImmerNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsBainDoucheImmerPreciPHLToni 		#923  PHL tonique (P10)\n        - medthePresSoinsBainDoucheImmerPreciPHLDrain 		#922  PHL drainant (P11)\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsBainDoucheImmerPreciRH    		#924  RH (P13)\n        - medthePresSoinsBainDoucheImmerPreciRHPHL 		#925  RH + PHL (P12)\n\r\n  row8:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Bain avec douche sous marine}     		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheSsMarinePhl1,nolabel 		#930  BainDoucheSsMarinePhl1\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheSsMarinePhl3,nolabel 		#931  BainDoucheSsMarinePhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheSsMarineGyn,nolabel 		#928  BainDoucheSsMarineGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheSsMarineRh1,nolabel 		#933  BainDoucheSsMarineRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheSsMarineRh3,nolabel 		#934  BainDoucheSsMarineRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsBainDoucheSsMarineNbSoins,nolabel 		#929  BainDoucheSsMarineNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsBainDoucheSsMarinePreciZones,nolabel 		#932  medtheBainDoucheSsMarinePreciZones\n        \r\n  row9:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Douche générale automatisée (DC)}		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheGenAutoRh1,nolabel  		#973  DoucheGenAutoRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheGenAutoRh3,nolabel  		#974  DoucheGenAutoRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheGenAutoNbSoins,nolabel 		#972  DoucheGenAutoNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsDoucheLocAutoPreciMinf    		#988  Douche colonne - membres inf.\n\r\n  row10:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Douche générale au jet}         		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheGenJetPhl1,nolabel  		#977  DoucheGenJetPhl1\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheGenJetPhl3,nolabel  		#978  DoucheGenJetPhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheGenJetGyn,nolabel   		#975  DoucheGenJetGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheGenJetRh1,nolabel   		#980  DoucheGenJetRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheGenJetRh3,nolabel   		#981  DoucheGenJetRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheGenJetNbSoins,nolabel 		#976  DoucheGenJetNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsDoucheGenJetPreciPosi,nolabel 		#979  DoucheGenJetPreciPosi\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medtheDoucheGenJetPreciAvecBaveuse       		#1248 Avec Baveuse\n        \r\n  row11:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Douche locale automatisée (BDS)} 		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheLocAutoPhl1,nolabel 		#985  DoucheLocAutoPhl1\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheLocAutoPhl3,nolabel 		#986  DoucheLocAutoPhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheLocAutoGyn,nolabel  		#983  DoucheLocAutoGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheLocAutoNbSoins,nolabel 		#984  DoucheLocAutoNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsDoucheLocAutoDuree,nolabel 		#982  DoucheLocAutoDuree\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsDoucheLocAutoPreciBds     		#987  Bain de siège\n\r\n    col10:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsDoucheLocAutoPreciPhlKneipp 		#989  Phl=Kneipp (K303)\n\r\n  row12:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Douche locale au jet (DLP)}       		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheLocJetPhl1,nolabel  		#992  DoucheLocJetPhl1\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheLocJetPhl3,nolabel  		#993  DoucheLocJetPhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheLocJetGyn,nolabel   		#990  DoucheLocJetGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheLocJetNbSoins,nolabel 		#991  DoucheLocJetNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsDoucheLocJetPreciCuisses  		#995  Cuisses\n        - medthePresSoinsDoucheLocJetPreciFessiers 		#996  Fessiers\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsDoucheLocJetPreciHanches  		#997  Hanches\n        - medthePresSoinsDoucheLocJetPreciVentre   		#998  Ventre\n\r\n    col10:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsDoucheLocJetPreciBras     		#994  Bras\n\r\n  row13:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Douche sous immersion en piscine} 		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheSsImmerPiscineRh1,nolabel 		#1001 DoucheSsImmerPiscineRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheSsImmerPiscineRh3,nolabel 		#1002 DoucheSsImmerPiscineRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsDoucheSsImmerPiscineNbSoins,nolabel 		#999  DoucheSsImmerPiscineNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsDoucheSsImmerPiscinePreciPression,nolabel 		#1000 DoucheSsImmerPiscinePreciPression\n\r\n  row14:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Pulvérisation des membres}       		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsPulvMembresPhl1,nolabel   		#1043 PulvMembresPhl1\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsPulvMembresPhl3,nolabel   		#1044 PulvMembresPhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsPulvMembresGyn,nolabel    		#1041 PulvMembresGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsPulvMembresNbSoins,nolabel 		#1042 PulvMembresNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsPulvMembresPreciMsup      		#1046 Membres sup.\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsPulvMembresPreciMinf      		#1045 Membres inf.\n\r\n    col10:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsPulvMembresPreciUlceres   		#1047 Ulcères\n\r\n  row15:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Illutation locale unique}         		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsIllutLocUniqueRh1,nolabel 		#1021 IllutLocUniqueRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsIllutLocUniqueRh3,nolabel 		#1022 IllutLocUniqueRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsIllutLocUniqueNbSoins,nolabel 		#1019 IllutLocUniqueNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsIllutLocUniquePreci,nolabel 		#1020 IllutLocUniquePreci\n\r\n  row16:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Illutation locale multiple}       		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsIllutLocMultiGyn,nolabel  		#1009 IllutLocMultiGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsIllutLocMultiRh1,nolabel  		#1011 IllutLocMultiRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsIllutLocMultiRh3,nolabel  		#1012 IllutLocMultiRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsIllutLocMultiNbSoins,nolabel 		#1010 IllutLocMultiNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsIllutLocPreciCou          		#1013 Cou\n        - medthePresSoinsIllutLocPreciEpaules      		#1016 Épaules\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsIllutLocPreciDos          		#1015 Dos\n        - medthePresSoinsIllutLocPreciHanches      		#1018 Hanches\n\r\n    col10:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsIllutLocPreciCoudes       		#1014 Coudes\n        - medthePresSoinsIllutLocPreciGenoux       		#1017 Genoux (tiède)\n\r\n  row17:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Cataplasme application locale unique}		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCataAppLocUniqueRh1,nolabel 		#958  CataAppLocUniqueRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCataAppLocUniqueRh3,nolabel 		#959  CataAppLocUniqueRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCataAppLocUniqueNbSoins,nolabel 		#956  CataAppLocUniqueNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsCataAppLocUniquePreci,nolabel 		#957  CataAppLocUniquePreci\n\r\n  row18:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Cataplasme application locale multiple}		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCataAppLccMultiRh1,nolabel 		#954  CataAppLccMultiRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCataAppLccMultiRh3,nolabel 		#955  CataAppLccMultiRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCataAppLccMultiNbSoins,nolabel 		#947  CataAppLccMultiNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsCataAppLccMultiPreciCou   		#948  Cou\n        - medthePresSoinsCataAppLccMultiPreciEpaules 		#951  Épaules\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsCataAppLccMultiPreciDos   		#950  Dos\n        - medthePresSoinsCataAppLccMultiPreciHanches 		#953  Hanches\n\r\n    col10:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsCataAppLccMultiPreciCoudes 		#949  Coudes\n        - medthePresSoinsCataAppLccMultiPreciGenoux 		#952  Genoux (tiède)\n\r\n  row19:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Compresses (+10 min repos)}       		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCompressesPhl1,nolabel    		#962  CompressesPhl1\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCompressesPhl3,nolabel    		#963  CompressesPhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCompressesGyn,nolabel     		#960  CompressesGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCompressesNbSoins,nolabel 		#961  CompressesNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsCompressesPreciMsup       		#965  Membres sup.\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsCompressesPreciMinf       		#964  Membres inf.\n\r\n    col10:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsCompressesPreciUlceres    		#966  Ulcères\n\r\n  row20:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Étuve locale}                    		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsEtuveLocRh1,nolabel       		#1007 EtuveLocRh1\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsEtuveLocRh3,nolabel       		#1008 EtuveLocRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsEtuveLocNbSoins,nolabel   		#1004 EtuveLocNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsEtuveLocPreciMains        		#1005 Mains\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsEtuveLocPreciPieds        		#1006 Pieds\n\r\n  row21:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Massage sous l\'eau kinésithérapie}		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsMassageSsEauKinePhl3,nolabel 		#1025 MassageSsEauKinePhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsMassageSsEauKineRh3,nolabel 		#1032 MassageSsEauKineRh3\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsMassageSsEauKineNbSoins,nolabel 		#1024 MassageSsEauKineNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsMassageSsEauKinePreciRHEff 		#1029 RH - Effleurage\n        - medthePresSoinsMassageSsEauKinePreciRHPetri 		#1030 RH - Pétrissage\n\r\n    col9:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsMassageSsEauKinePreciPHLJambes 		#1028 PHL - Jambes\n        - medthePresSoinsMassageSsEauKinePreciPHLDos 		#1027 PHL - Dos\n        - medthePresSoinsMassageSsEauKinePreciPHLBras 		#1026 PHL - Bras\n\r\n    col10:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsMassageSsEauKinePreciZones 		#1031 MassageSsEauKinePreciZones\n        - medthePresSoinsMassageSsEauKineAutresSiPasDispo 		#1249 Autres soins si pas dispo\n\r\n  row22:\r\n    class: border-bottom py-1\r\n    col1:\r\n      size: col-3\r\n      bloc:\r\n        - label{Couloir de marche}                		\n    col2:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCouloirMarchePhl1,nolabel 		#969  CouloirMarchePhl1\n    col3:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCouloirMarchePhl3,nolabel 		#970  CouloirMarchePhl3\n    col4:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCouloirMarcheGyn,nolabel  		#967  CouloirMarcheGyn\n    col5:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col6:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - label{ }                                		\n    col7:\r\n      size: col\r\n      class: colFormSoinsFixWidth\r\n      bloc:\r\n        - medthePresSoinsCouloirMarcheNbSoins,nolabel 		#968  CouloirMarcheNbSoins\n\r\n    col8:\r\n      size: col\r\n      bloc: \r\n        - medthePresSoinsCouloirMarchePreci,nolabel 		#971  CouloirMarchePreci\n\r\n  row23:\r\n    class: py-1 mb-4 mt-4\r\n    col1:\r\n      size: col-12\r\n      bloc:\r\n        - medthePresSoinsObservations,row=2        		#1033 Observations' WHERE `module`='medtherm' AND `internalName`='medtheFormPresSoins';

-- Mise à jour du formulaire de courrier au médecin traitant
UPDATE `forms` SET `yamlStructure`='structure:\r\n  row1:\r\n    head: \"Courrier de synthèse\"\r\n    col1:\r\n      size: col-6\r\n      bloc:\r\n        - medtheCouMtAvecDonneMedical              		#380  Inclure les données médicales\n    col2:\r\n      size: col-6\r\n      bloc:\r\n        - medtheCouMtAvecCsAutres                  		#381  Inclure les consultations autres\n  row2:\r\n    col1:\r\n      size: col-2\r\n      bloc: \r\n        - medtheCouMtDateDebut                     		#203  Date de début\n    col2:\r\n      size: col-2\r\n      bloc: \r\n        - medtheCouMtDateFin                       		#204  Date de fin\n    col3:\r\n      size: col-8\r\n      bloc: \r\n        - medtheCouMtOrientations                  		#206  Orientations\n        \r\n  row3:\r\n    col1:\r\n      size: col-2\r\n      bloc: \r\n        - medtheCouMtTaille,readonly,plus={cm},class={text-right} 		#217  Taille\n    col2:\r\n      size: col-2\r\n      bloc: \r\n        - medtheCouMtPoidsInitial,readonly,plus={kg},class={text-right} 		#209  Poids initial\n    col3:\r\n      size: col-2\r\n      bloc: \r\n        - medtheCouMtPoidsFinal,readonly,plus={kg},class={text-right} 		#208  Poids final\n    col4:\r\n      size: col-2\r\n      bloc:                          \r\n        - medtheCouMtImcInitial,readonly,class=text-right,plus={kg/m²} 		#384  IMC Initial\n    col5:\r\n      size: col-2\r\n      bloc:                          \r\n        - medtheCouMtImcFinal,readonly,class=text-right,plus={kg/m²} 		#385  IMC Final\n\r\n  row4:\r\n    col1:\r\n      size: col-12\r\n      bloc: \r\n        - medtheCouMtPathoAlgies,rows=3            		#207  Pathologies et algies\n\r\n  row5:\r\n    col1:\r\n      size: col\r\n      bloc: \r\n        - label{ }                                		\n        - label{1re consultation},class={fakeFormBloc}		\n        - label{2e consultation},class={fakeFormBloc}		\n        - label{3e consultation},class={fakeFormBloc}		\n    col2:\r\n      size: col\r\n      bloc: \r\n        - label{TAS}                              		\n        - medtheCouMtTASC1,nolabel,plus={mmHg},class={text-right} 		#214  TAS C1\n        - medtheCouMtTASC2,nolabel,plus={mmHg},class={text-right} 		#215  TAS C2\n        - medtheCouMtTASC3,nolabel,plus={mmHg},class={text-right} 		#216  TAS C3\n    col3:\r\n      size: col\r\n      bloc: \r\n        - label{TAD}                              		\n        - medtheCouMtTADC1,nolabel,plus={mmHg},class={text-right} 		#211  TAD C1\n        - medtheCouMtTADC2,nolabel,plus={mmHg},class={text-right} 		#212  TAD C2\n        - medtheCouMtTADC3,nolabel,plus={mmHg},class={text-right} 		#213  TAD C3\n    col4:\r\n      size: col\r\n      bloc: \r\n        - label{Cheville D}                       		\n        - medtheCouMtCs1CircoChevilleDt,nolabel,plus={cm},class={text-right} 		#195  Circonférence cheville droite C1\n        - label{ },class={fakeFormBloc}           		\n        - medtheCouMtCs3CircoChevilleDt,nolabel,plus={cm},class={text-right} 		#199  Circonférence cheville droite C3\n    col5:\r\n      size: col\r\n      bloc: \r\n        - label{Cheville G}                       		\n        - medtheCouMtCs1CircoChevilleG,nolabel,plus={cm},class={text-right} 		#196  Circonférence cheville gauche C1\n        - label{ },class={fakeFormBloc}           		\n        - medtheCouMtCs3CircoChevilleG,nolabel,plus={cm},class={text-right} 		#200  Circonférence cheville gauche C3\n    col6:\r\n      size: col\r\n      bloc: \r\n        - label{Mollet D}                         		\n        - medtheCouMtCs1CircoMolletDt,nolabel,plus={cm},class={text-right} 		#197  Circonférence mollet droit C1\n        - label{ },class={fakeFormBloc}           		\n        - medtheCouMtCs3CircoMolletDt,nolabel,plus={cm},class={text-right} 		#201  Circonférence mollet droit C3\n    col7:\r\n      size: col\r\n      bloc: \r\n        - label{Mollet G}                         		\n        - medtheCouMtCs1CircoMolletG,nolabel,plus={cm},class={text-right} 		#198  Circonférence mollet gauche C1\n        - label{ },class={fakeFormBloc}           		\n        - medtheCouMtCs3CircoMolletG,nolabel,plus={cm},class={text-right} 		#202  Circonférence mollet gauche C3\n  row6:\r\n    class: courMtAtcdHideShow\r\n    col1:                            \r\n      size: col-12\r\n      bloc:\r\n        - allergies,rows=1                         		#21   Allergies\n        - medtheAtcdPersoMedicaux                  		#184  Antécédents médicaux\n        - medtheAtcdPersoChirugicaux               		#183  Antécédents chirugicaux\n        - medtheAtcdTraitementChro                 		#185  Traitement chronique\n        - medtheAtcdDivers                         		#182  Divers\n\r\n  row7:\r\n    class: courMtAtcdHideShow\r\n    col1:                            \r\n      size: col-12 col-md-6\r\n      bloc:\r\n        - insuffisanceRenale                       		#181  Insuffisance rénale\n    col2:                            \r\n      size: col-12 col-md-6\r\n      bloc:\r\n        - creatinineMicroMolL,plus={µmol/L},class={text-right} 		#75   Créatinine\n        \r\n  row8:\r\n    class: courMtAtcdHideShow\r\n    col1:                            \r\n      size: col-12\r\n      bloc:\r\n        - insuffisanceHepatique                    		#27   Insuffisance hépatique\n        \r\n  row9:\r\n    class: courMtAtcdHideShow\r\n    col1:                            \r\n      size: col-12 col-md-6\r\n      bloc:\r\n        - grossesseActuelle                        		#26   Grossesse en cours\n    col2:                            \r\n      size: col-12 col-md-6\r\n      bloc:\r\n        - allaitementActuel                        		#20   Allaitement\n  row10:\r\n    col1:\r\n      size: col-6\r\n      bloc: \r\n        - medtheCouMtSoins,rows=3                  		#210  Soins\n    col2:\r\n      size: col-6\r\n      bloc: \r\n        - medtheCouMtObservation,rows=3            		#205  Observation\n  row11:\r\n    class: courMtCsAutresShowHide\r\n    col1:\r\n      size: col-12\r\n      bloc:\r\n        - medtheCouMtResumCsAut,rows=10            		#379  Résumé des consultation autres' WHERE ` module`='medtherm' AND `internalName`='medtheFormCourrierMT';
UPDATE `forms` SET `javascript`='$(document).ready(function() {\r\n  \r\n  // Voire ou non le bloc Donnée médicales\r\n  function showATCD(show) {\r\n        if (show) { $(\'.courMtAtcdHideShow\').show(); }\r\n        else { $(\'.courMtAtcdHideShow\').hide(); }\r\n  };\r\n\r\n  // Voire ou non les consultation autres\r\n  function showCsAutres(show) {\r\n          if (show) { $(\'.courMtCsAutresShowHide\').show(); }\r\n          else { $(\'.courMtCsAutresShowHide\').hide(); }\r\n  };\r\n\r\n  // Masquer ou non les bloc selon la valeur des champ gérant leur affichage\r\n  $(\'#id_medtheCouMtAvecDonneMedical_id\').change(function() { showATCD(($(this).val() == \"true\")); });\r\n  $(\'#id_medtheCouMtAvecCsAutres_id\').change(function() { showCsAutres(($(this).val() == \"true\")); });\r\n\r\n  // Voire ou non les bloc Données médicales et autres consultation en fonction de leur valeur par default\r\n  showATCD(($(\'#id_medtheCouMtAvecDonneMedical_id\').val() == \"true\"));\r\n  showCsAutres(($(\'#id_medtheCouMtAvecCsAutres_id\').val() == \"true\"));\r\n  \r\n  // Utilise tinymce pour formater le champ des consultation autres\r\n  if (tinymce.get(\'id_medtheCouMtResumCsAut_id\') !== null) {\r\n    tinymce.remove(\'#id_medtheCouMtResumCsAut_id\');\r\n  };\r\n  tinymce.init({\r\n    selector: \'#id_medtheCouMtResumCsAut_id\',\r\n    height: \'500\'\r\n  });\r\n  \r\n  //autoresize\r\n  autosize($(\'#formName_medtheFormCourrierMT textarea\'));\r\n});' WHERE ` module`='medtherm' AND `internalName`='medtheFormCourrierMT';

-- Mise à jour label champs
SET @catID = (SELECT data_cat.id FROM data_cat WHERE data_cat.name='medtheCatCourrierMT');
UPDATE `froms` SET `data_types`='Consultations' WHERE `name` = 'medtheCouMtObservation' AND  `cat` = @catID;
