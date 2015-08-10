From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 2/3 v3] Add default case to switches on enum variables
Date: Mon, 10 Aug 2015 08:35:32 -0400
Message-ID: <1439210132-19384-1-git-send-email-tcamuso@redhat.com>
References: <1438216001-8862-3-git-send-email-tcamuso@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54676 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbbHJMfd (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 10 Aug 2015 08:35:33 -0400
In-Reply-To: <1438216001-8862-3-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: tcamuso@redhat.com, sparse@chrisli.org, nicstange@gmail.com

Missing enum members in case statements in c2xml.c and parse.c were
causing compile time complaints by gcc 5.1.1. Adding a default case
satisfies the compiler and notifies the reviewer that there are
cases not explicitly mentioned being handled by the default case.

Signed-off-by: Tony Camuso <tcamuso@redhat.com>

---
 c2xml.c | 3 ++-
 parse.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/c2xml.c b/c2xml.c
index 67486c7..c45d581 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -214,6 +214,8 @@ static void examine_symbol(struct symbol *sym, xmlNodePtr node)
 	case SYM_UNINITIALIZED:
 		newProp(child, "base-type-builtin", builtin_typename(sym));
 		break;
+	default:
+		break;
 	}
 	return;
 }
@@ -330,4 +332,3 @@ int main(int argc, char **argv)
 
 	return 0;
 }
