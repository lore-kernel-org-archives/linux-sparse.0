From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/5] Fix some "enum value 'SYM_...' not handled in switch"
 warnings
Date: Sat, 18 Jul 2009 21:41:46 +0100
Message-ID: <4A62338A.1060600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:41075 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753697AbZGRVJx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Jul 2009 17:09:53 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

These warnings were issued by gcc v3.4.4, but not by gcc v4.1.2.
So I guess gcc probably found these warnings to be too noisy ...

ATB,
Ramsay Jones

 parse.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/parse.c b/parse.c
index e5ad867..42e8c74 100644
--- a/parse.c
+++ b/parse.c
@@ -2616,6 +2616,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			case SYM_ENUM:
 			case SYM_RESTRICT:
 				base_type->ident = ident;
+			default:
+				break;
 			}
 		}
 	} else if (base_type && base_type->type == SYM_FN) {
-- 
1.6.3.1


