From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux kernel warnings/errors (#8)
Date: Tue, 23 Feb 2010 16:55:29 -0800
Message-ID: <4B847901.2050803@xenotime.net>
References: <20100223114906.61d4e001.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090705020802090902050503"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.64.118]:37827 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753555Ab0BXAzb (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Feb 2010 19:55:31 -0500
Received: from chimera.site ([71.245.98.113]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 23 Feb 2010 16:55:29 -0800
In-Reply-To: <20100223114906.61d4e001.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is a multi-part message in MIME format.
--------------090705020802090902050503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 02/23/10 11:49, Randy Dunlap wrote:
> Hi,
> 
> You probably know that sparse produces a ton of errors & warnings when
> run on the Linux kernel tree (a little over 1 MB in my latest 'make C=1'
> on x86_64 arch.).
> 
> I'm wondering if all of these are valid.
> 
> Examples:


8.  There are many cases of sparse "error: bad integer constant expression"
that gcc handles without a problem, when the constant expression uses a
macro or static inline function:

a.  drivers/gpu/drm/drm_drv.c:59:9: error: bad integer constant expression

static struct drm_ioctl_desc drm_ioctls[] = {
	DRM_IOCTL_DEF(DRM_IOCTL_VERSION, drm_version, 0),

b.  drivers/media/video/v4l2-ioctl.c:185:10: error: bad integer constant expression

static const char *v4l1_ioctls[] = {
	[_IOC_NR(VIDIOCGCAP)]       = "VIDIOCGCAP",
};

c.  fs/proc/array.c:154:9: error: bad integer constant expression

	BUILD_BUG_ON(1 + ilog2(TASK_STATE_MAX) != ARRAY_SIZE(task_state_array));

d.  sound/pci/hda/hda_proc.c:422:18: error: bad integer constant expression

	static char *names[] = {
		[ilog2(AC_PWRST_D0SUP)]		= "D0",
	};

e.  drivers/gpu/drm/drm_ioc32.c:1017:10: error: bad integer constant expression

drm_ioctl_compat_t *drm_compat_ioctls[] = {
	[DRM_IOCTL_NR(DRM_IOCTL_VERSION32)] = compat_drm_version,
};


I have a test case for "d." above.
(attached)

> sparse  const_sound.c 
const_sound.c:114:18: error: bad integer constant expression



-- 
~Randy

--------------090705020802090902050503
Content-Type: text/x-csrc;
 name="const_sound.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="const_sound.c"

#include <asm-generic/ioctl.h>


static inline __attribute__((const))
int fls(unsigned int n)
{
	return 0;
}

static inline __attribute__((const))
int fls64(unsigned int n)
{
	return 63;
}

static inline __attribute__((const))
int __ilog2_u32(unsigned int n)
{
	return fls(n) - 1;
}

static inline __attribute__((const))
int __ilog2_u64(unsigned long n)
{
	return fls64(n) - 1;
}

static inline __attribute__((const))
int ____ilog2_NaN(void)
{
	return -1;
}

#define ilog2(n)				\
(						\
	__builtin_constant_p(n) ? (		\
		(n) < 1 ? ____ilog2_NaN() :	\
		(n) & (1ULL << 63) ? 63 :	\
		(n) & (1ULL << 62) ? 62 :	\
		(n) & (1ULL << 61) ? 61 :	\
		(n) & (1ULL << 60) ? 60 :	\
		(n) & (1ULL << 59) ? 59 :	\
		(n) & (1ULL << 58) ? 58 :	\
		(n) & (1ULL << 57) ? 57 :	\
		(n) & (1ULL << 56) ? 56 :	\
		(n) & (1ULL << 55) ? 55 :	\
		(n) & (1ULL << 54) ? 54 :	\
		(n) & (1ULL << 53) ? 53 :	\
		(n) & (1ULL << 52) ? 52 :	\
		(n) & (1ULL << 51) ? 51 :	\
		(n) & (1ULL << 50) ? 50 :	\
		(n) & (1ULL << 49) ? 49 :	\
		(n) & (1ULL << 48) ? 48 :	\
		(n) & (1ULL << 47) ? 47 :	\
		(n) & (1ULL << 46) ? 46 :	\
		(n) & (1ULL << 45) ? 45 :	\
		(n) & (1ULL << 44) ? 44 :	\
		(n) & (1ULL << 43) ? 43 :	\
		(n) & (1ULL << 42) ? 42 :	\
		(n) & (1ULL << 41) ? 41 :	\
		(n) & (1ULL << 40) ? 40 :	\
		(n) & (1ULL << 39) ? 39 :	\
		(n) & (1ULL << 38) ? 38 :	\
		(n) & (1ULL << 37) ? 37 :	\
		(n) & (1ULL << 36) ? 36 :	\
		(n) & (1ULL << 35) ? 35 :	\
		(n) & (1ULL << 34) ? 34 :	\
		(n) & (1ULL << 33) ? 33 :	\
		(n) & (1ULL << 32) ? 32 :	\
		(n) & (1ULL << 31) ? 31 :	\
		(n) & (1ULL << 30) ? 30 :	\
		(n) & (1ULL << 29) ? 29 :	\
		(n) & (1ULL << 28) ? 28 :	\
		(n) & (1ULL << 27) ? 27 :	\
		(n) & (1ULL << 26) ? 26 :	\
		(n) & (1ULL << 25) ? 25 :	\
		(n) & (1ULL << 24) ? 24 :	\
		(n) & (1ULL << 23) ? 23 :	\
		(n) & (1ULL << 22) ? 22 :	\
		(n) & (1ULL << 21) ? 21 :	\
		(n) & (1ULL << 20) ? 20 :	\
		(n) & (1ULL << 19) ? 19 :	\
		(n) & (1ULL << 18) ? 18 :	\
		(n) & (1ULL << 17) ? 17 :	\
		(n) & (1ULL << 16) ? 16 :	\
		(n) & (1ULL << 15) ? 15 :	\
		(n) & (1ULL << 14) ? 14 :	\
		(n) & (1ULL << 13) ? 13 :	\
		(n) & (1ULL << 12) ? 12 :	\
		(n) & (1ULL << 11) ? 11 :	\
		(n) & (1ULL << 10) ? 10 :	\
		(n) & (1ULL <<  9) ?  9 :	\
		(n) & (1ULL <<  8) ?  8 :	\
		(n) & (1ULL <<  7) ?  7 :	\
		(n) & (1ULL <<  6) ?  6 :	\
		(n) & (1ULL <<  5) ?  5 :	\
		(n) & (1ULL <<  4) ?  4 :	\
		(n) & (1ULL <<  3) ?  3 :	\
		(n) & (1ULL <<  2) ?  2 :	\
		(n) & (1ULL <<  1) ?  1 :	\
		(n) & (1ULL <<  0) ?  0 :	\
		____ilog2_NaN()			\
				   ) :		\
	(sizeof(n) <= 4) ?			\
	__ilog2_u32(n) :			\
	__ilog2_u64(n)				\
 )

// d.  sound/pci/hda/hda_proc.c:422:18: error: bad integer constant expression

#define AC_PWRST_D0SUP			(1<<0)

	static char *names[] = {
		[ilog2(AC_PWRST_D0SUP)]		= "D0",
	};


int main(int argc, char *argv[])
{
}

--------------090705020802090902050503--
