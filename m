From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [FAIL 1/5] parse: Add comment to struct statement
Date: Wed, 17 Feb 2016 10:51:31 +0100
Message-ID: <1455702695-6199-2-git-send-email-daniel.wagner@bmw-carit.de>
References: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>
List-Id: linux-sparse@vger.kernel.org

All the other members of the union got a nice comment
what they represent. Let's fix for context as well.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 parse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.h b/parse.h
index 0c34ec2..195f0fd 100644
--- a/parse.h
+++ b/parse.h
@@ -51,7 +51,7 @@ struct statement {
 		struct /* declaration */ {
 			struct symbol_list *declaration;
 		};
-		struct {
+		struct /* context */ {
 			struct expression *expression;
 			struct expression *context;
 		};
-- 
2.5.0
