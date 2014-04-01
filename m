From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] Fix _IOC_TYPECHECK sparse error
Date: Tue, 01 Apr 2014 09:04:12 +0200
Message-ID: <533A64EC.2090106@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Christopher Li <sparse@chrisli.org>
List-Id: linux-sparse@vger.kernel.org

When running sparse over drivers/media/v4l2-core/v4l2-ioctl.c I get these
errors:

drivers/media/v4l2-core/v4l2-ioctl.c:2043:9: error: bad integer constant expression
drivers/media/v4l2-core/v4l2-ioctl.c:2044:9: error: bad integer constant expression
drivers/media/v4l2-core/v4l2-ioctl.c:2045:9: error: bad integer constant expression
drivers/media/v4l2-core/v4l2-ioctl.c:2046:9: error: bad integer constant expression

etc.

The root cause of that turns out to be in include/asm-generic/ioctl.h:

#include <uapi/asm-generic/ioctl.h>

/* provoke compile error for invalid uses of size argument */
extern unsigned int __invalid_size_argument_for_IOC;
#define _IOC_TYPECHECK(t) \
        ((sizeof(t) == sizeof(t[1]) && \
          sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
          sizeof(t) : __invalid_size_argument_for_IOC)

If it is defined as this (as is already done if __KERNEL__ is not defined):

#define _IOC_TYPECHECK(t) (sizeof(t))

then all is well with the world.

This patch allows sparse to work correctly.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>

diff --git a/include/asm-generic/ioctl.h b/include/asm-generic/ioctl.h
index d17295b..297fb0d 100644
--- a/include/asm-generic/ioctl.h
+++ b/include/asm-generic/ioctl.h
@@ -3,10 +3,15 @@
 
 #include <uapi/asm-generic/ioctl.h>
 
+#ifdef __CHECKER__
+#define _IOC_TYPECHECK(t) (sizeof(t))
+#else
 /* provoke compile error for invalid uses of size argument */
 extern unsigned int __invalid_size_argument_for_IOC;
 #define _IOC_TYPECHECK(t) \
 	((sizeof(t) == sizeof(t[1]) && \
 	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
 	  sizeof(t) : __invalid_size_argument_for_IOC)
+#endif
+
 #endif /* _ASM_GENERIC_IOCTL_H */
