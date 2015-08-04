From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 2/3 v2] Handle all enum members in case statements
Date: Tue,  4 Aug 2015 08:06:34 -0400
Message-ID: <1438689994-30940-1-git-send-email-tcamuso@redhat.com>
References: <1438216001-8862-3-git-send-email-tcamuso@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55043 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933307AbbHDMGf (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 4 Aug 2015 08:06:35 -0400
In-Reply-To: <1438216001-8862-3-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org, linux-sparse@vger.kernel.org
Cc: tcamuso@redhat.com, nicstange@gmail.com

Missing enum members in case statements in c2xml.c and parse.c were
causing compile time complaints by gcc 5.1.1. Better to explicitly
handle all enum members of the switch variable in case statements,
even if they just break.

Signed-off-by: Tony Camuso <tcamuso@redhat.com>
---
 c2xml.c | 16 ++++++++++++++++
 parse.c | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/c2xml.c b/c2xml.c
index 67486c7..a53f5bd 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -214,6 +214,22 @@ static void examine_symbol(struct symbol *sym, xmlNodePtr node)
 	case SYM_UNINITIALIZED:
 		newProp(child, "base-type-builtin", builtin_typename(sym));
 		break;
+	case SYM_PREPROCESSOR:
+	case SYM_BASETYPE:
+	case SYM_NODE:
+	case SYM_PTR:
+	case SYM_ARRAY:
+	case SYM_ENUM:
+	case SYM_TYPEDEF:
+	case SYM_TYPEOF:
+	case SYM_MEMBER:
+	case SYM_BITFIELD:
+	case SYM_LABEL:
+	case SYM_RESTRICT:
+	case SYM_FOULED:
+	case SYM_KEYWORD:
+	case SYM_BAD:
+		break;
 	}
 	return;
 }
diff --git a/parse.c b/parse.c
index b43d683..74a56e4 100644
--- a/parse.c
+++ b/parse.c
@@ -2769,6 +2769,21 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			case SYM_ENUM:
 			case SYM_RESTRICT:
 				base_type->ident = ident;
+			case SYM_PREPROCESSOR:
+			case SYM_BASETYPE:
+			case SYM_NODE:
+			case SYM_PTR:
+			case SYM_FN:
+			case SYM_ARRAY:
+			case SYM_TYPEDEF:
+			case SYM_TYPEOF:
+			case SYM_MEMBER:
+			case SYM_BITFIELD:
+			case SYM_LABEL:
+			case SYM_FOULED:
+			case SYM_KEYWORD:
+			case SYM_BAD:
+				break;
 			}
 		}
 	} else if (base_type && base_type->type == SYM_FN) {
-- 
2.4.3

