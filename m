From: Tony Camuso <tcamuso@redhat.com>
Subject: [PATCH 2/3] c2xml.c, parse.c: gcc 5+ stricter case statement parsing
Date: Wed, 29 Jul 2015 20:26:40 -0400
Message-ID: <1438216001-8862-3-git-send-email-tcamuso@redhat.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60861 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbbG3A0x (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Jul 2015 20:26:53 -0400
In-Reply-To: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org, linux-sparse@vger.kernel.org
Cc: tcamuso@redhat.com

The gcc 5+ compiler complains if case statements do not use all the
possible values of the switch variable. Just forces the coder to use
"default" in their case statements.

Signed-off-by: Tony Camuso <tcamuso@redhat.com>
---
 c2xml.c | 2 +-
 parse.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/c2xml.c b/c2xml.c
index 67486c7..96657d5 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -214,6 +214,7 @@ static void examine_symbol(struct symbol *sym, xmlNodePtr node)
 	case SYM_UNINITIALIZED:
 		newProp(child, "base-type-builtin", builtin_typename(sym));
 		break;
+	default: break;
 	}
 	return;
 }
@@ -330,4 +331,3 @@ int main(int argc, char **argv)
 
 	return 0;
 }
