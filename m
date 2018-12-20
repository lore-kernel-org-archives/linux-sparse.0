From: Tycho Andersen <tycho@tycho.ws>
Subject: [RFC v1 1/4] expression.h: update comment to include other cast types
Date: Thu, 20 Dec 2018 12:59:28 -0700
Message-ID: <20181220195931.20331-2-tycho@tycho.ws>
References: <20181220195931.20331-1-tycho@tycho.ws>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kernel-hardening-return-14772-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <20181220195931.20331-1-tycho@tycho.ws>
To: linux-sparse@vger.kernel.org, kernel-hardening@lists.openwall.com
Cc: Tycho Andersen <tycho@tycho.ws>
List-Id: linux-sparse@vger.kernel.org

This part of the union is used with other cast types as well, so let's
include those in the comment.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 expression.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/expression.h b/expression.h
index ba4157f..fece40d 100644
--- a/expression.h
+++ b/expression.h
@@ -187,7 +187,7 @@ struct expression {
 			struct expression *base;
 			unsigned r_bitpos, r_nrbits;
 		};
-		// EXPR_CAST and EXPR_SIZEOF
+		// EXPR_CAST, FORCE_CAST, EXPR_IMPLIED_CAST and EXPR_SIZEOF
 		struct /* cast_arg */ {
 			struct symbol *cast_type;
 			struct expression *cast_expression;
-- 
2.19.1
