From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 2/2] Compiler Attributes: auxdisplay: panel: use __fallthrough
Date: Sun, 21 Oct 2018 19:14:14 +0200
Message-ID: <20181021171414.22674-3-miguel.ojeda.sandonis@gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>David
List-Id: linux-sparse@vger.kernel.org

Let gcc know these cases are meant to fall through to the next label
by annotating them with the new __fallthrough statement attribute;
and remove the comment since it conveys the same information
(which was also parsed by gcc to suppress the warning).

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 drivers/auxdisplay/panel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 21b9b2f2470a..0755034e49ba 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1367,7 +1367,7 @@ static void panel_process_inputs(void)
 				break;
 			input->rise_timer = 0;
 			input->state = INPUT_ST_RISING;
-			/* fall through */
+			__fallthrough;
 		case INPUT_ST_RISING:
 			if ((phys_curr & input->mask) != input->value) {
 				input->state = INPUT_ST_LOW;
@@ -1380,11 +1380,11 @@ static void panel_process_inputs(void)
 			}
 			input->high_timer = 0;
 			input->state = INPUT_ST_HIGH;
-			/* fall through */
+			__fallthrough;
 		case INPUT_ST_HIGH:
 			if (input_state_high(input))
 				break;
-			/* fall through */
+			__fallthrough;
 		case INPUT_ST_FALLING:
 			input_state_falling(input);
 		}
-- 
2.17.1
