From: "Mitesh Shah" <mshah@teja.com>
Subject: assignment expressions are not validated
Date: Tue, 21 Mar 2006 12:37:00 -0800
Message-ID: <AKEOJDDJLNPHDAKOMMBHGEGDCJAA.mshah@teja.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.teja.com ([209.10.202.133]:33988 "EHLO mail.teja.com")
	by vger.kernel.org with ESMTP id S1751586AbWCUUf4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Mar 2006 15:35:56 -0500
Received: from SURAT ([172.20.3.88])
	(authenticated user mshah@teja.com)
	by mail.teja.com (Kerio MailServer 6.0.8)
	for linux-sparse@vger.kernel.org;
	Tue, 21 Mar 2006 12:35:48 -0800
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>


There is no error/warning for the following code:

void f(void) {

  int a;

  a = ;

}


Looks like there is no check for empty expression in primary_expression.
default case simply ignores the token. Instead we can add a sparse_error
at line 360.

-Mitesh



 Index: expression.c
===================================================================
RCS file: /home/cvs/root/sparse-bk/expression.c,v
retrieving revision 1.10
diff -u -r1.10 expression.c
--- expression.c        16 Nov 2005 23:28:58 -0000      1.10
+++ expression.c        21 Mar 2006 20:36:52 -0000
@@ -357,7 +357,7 @@
                }

        default:
-               ;
+               sparse_error(token->pos, "Expected an expression");
        }
        *tree = expr;
        return token;


