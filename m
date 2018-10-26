From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH sparse] parse: shifting by full number of bits is undefined
Date: Fri, 26 Oct 2018 05:17:00 +0200
Message-ID: <20181026031700.12310-1-Jason@zx2c4.com>
References: <CAHmME9oZk7Afns=W=xM=6waqvVfV+iAdAcB6731xzUUcm4P0zA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHmME9oZk7Afns=W=xM=6waqvVfV+iAdAcB6731xzUUcm4P0zA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
List-Id: linux-sparse@vger.kernel.org

The type checker wasn't identifying upper bounds for huge unsigned
64-bit numbers, because the right shift turned into a no-op:

zx2c4@thinkpad /tmp $ cat sparse.c
enum { sparse_does_not_like_this = 0x8000000000000003ULL };
zx2c4@thinkpad /tmp $ sparse sparse.c
sparse.c:1:36: warning: cast truncates bits from constant value (8000000000000003 becomes 3)

This works around the issue by detecting when we're going to shift by
the size of the variable and treat that as always zero.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 02a55a7..02d0615 100644
--- a/parse.c
+++ b/parse.c
@@ -788,7 +788,7 @@ static int type_is_ok(struct symbol *type, Num *upper, Num *lower)
 
 	if (!is_unsigned)
 		shift--;
-	if (upper->x == 0 && upper->y >> shift)
+	if (upper->x == 0 && (shift < (sizeof(upper->y) << 3)) && upper->y >> shift)
 		return 0;
 	if (lower->x == 0 || (!is_unsigned && (~lower->y >> shift) == 0))
 		return 1;
-- 
2.19.1
