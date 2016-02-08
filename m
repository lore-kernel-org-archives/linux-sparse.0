From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: teach do_initializer() to handle the nested
 EXPR_IDENTIFIER's
Date: Mon, 8 Feb 2016 16:13:28 +0100
Message-ID: <20160208151328.GA24783@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37587 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbcBHPNa (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Feb 2016 10:13:30 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

do_initializer() is very limited/buggy but it was able to parse the kernel
code until ftrace started to use ".a.b = x" rather than ".a = { .b = x }"
in initializers.

Test-case:

	struct O {
		struct I {
			int mem;
		} inn;
		int end;
	} var = {
		.inn.mem = 0,
		0,
	};

before the patch:

	1:8   s def  O
	2:16  s def  I
	6:3   g def  var                              struct O
	6:3   g -w-  var                              struct O
	7:10  s -w-  O.inn                            struct I
	7:10  s -w-  I.*                              struct I
	I.c:7:14: warning: bad expr->type: 25
	8:9   s -w-  O.end                            int

after:

	1:8   s def  O
	2:16  s def  I
	6:3   g def  var                              struct O
	6:3   g -w-  var                              struct O
	7:10  s -w-  O.inn                            struct I
	7:14  s -w-  I.mem                            int
	8:9   s -w-  O.end                            int

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/dissect.c b/dissect.c
index 19f3276..2d13d2a 100644
--- a/dissect.c
+++ b/dissect.c
@@ -547,18 +547,23 @@ static struct symbol *do_initializer(struct symbol *type, struct expression *exp
 				if (m_expr->type == EXPR_INDEX)
 					m_expr = m_expr->idx_expression;
 			} else {
-				struct position *pos = &m_expr->pos;
-				struct ident *m_name = NULL;
+				int *m_atop = &m_addr;
 
-				if (m_expr->type == EXPR_IDENTIFIER) {
-					m_name = m_expr->expr_ident;
+				m_type = type;
+				while (m_expr->type == EXPR_IDENTIFIER) {
+					m_type = report_member(U_W_VAL, &m_expr->pos, m_type,
+							lookup_member(m_type, m_expr->expr_ident, m_atop));
 					m_expr = m_expr->ident_expression;
+					m_atop = NULL;
+				}
+
+				if (m_atop) {
+					m_type = report_member(U_W_VAL, &m_expr->pos, m_type,
+							lookup_member(m_type, NULL, m_atop));
 				}
 
-				m_type = report_member(U_W_VAL, pos, type,
-						lookup_member(type, m_name, &m_addr));
 				if (m_expr->type != EXPR_INITIALIZER)
-					report_implicit(U_W_VAL, pos, m_type);
+					report_implicit(U_W_VAL, &m_expr->pos, m_type);
 			}
 			do_initializer(m_type, m_expr);
 			m_addr++;
-- 
2.5.0


