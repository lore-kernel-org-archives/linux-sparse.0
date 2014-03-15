From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: sparse: ioctl defines and "error: bad integer constant expression"
Date: Sat, 15 Mar 2014 12:59:14 +0100
Message-ID: <53244092.6010906@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

Hi!

Here is another sparse error that I get when running sparse over
drivers/media/v4l2-core/v4l2-ioctl.c:

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

If it is defined as this:

#define _IOC_TYPECHECK(t) (sizeof(t))

then all is well with the world.

I can patch v4l2-ioctl.c to redefine _IOC_TYPECHECK if __CHECKER__ is defined, but
shouldn't sparse understand this instead? There was a similar situation with
ARRAY_SIZE in the past that sparse now understands.

Regards,

	Hans
