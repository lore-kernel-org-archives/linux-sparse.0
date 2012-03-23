From: Frederic Crozat <fcrozat@suse.com>
Subject: Re: Patch: add __builtin_stpcpy and __sync_synchronize to builtin
 functions
Date: Fri, 23 Mar 2012 10:32:58 +0100
Message-ID: <1332495178.15662.4.camel@par-r81vxc7.par.novell.com>
References: <1331820943.2720.5.camel@par-r81vxc7.par.novell.com>
	 <CANeU7QmikoVWVuVo1nWdgADoKD30iTCSirM+S1c9-aRd7hEa0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-J+k8viTxJt5JqCGVyafh"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.2]:54110 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab2CWJdB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2012 05:33:01 -0400
In-Reply-To: <CANeU7QmikoVWVuVo1nWdgADoKD30iTCSirM+S1c9-aRd7hEa0Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org


--=-J+k8viTxJt5JqCGVyafh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Le vendredi 23 mars 2012 à 01:26 -0700, Christopher Li a écrit :
> On Thu, Mar 15, 2012 at 7:15 AM, Frederic Crozat <fcrozat@suse.com> wrote:
> > while working on integrating sparse checks in systemd, I noticed some
> > builtin functions need to be added to sparse list. See attached patch
> > for the fix.
> 
> Catching up my backlogs. I just find out this patch does not have sign off.
> 
> Can you add a sign off line please?

Sorry, I didn't knew you needed this.

I've update the patch with adding yet another sync barrier which is now used in systemd.

-- 
Frederic Crozat <fcrozat@suse.com>
SUSE


--=-J+k8viTxJt5JqCGVyafh
Content-Disposition: inline;
	filename*0=0001-Add-__builtin_stpcpy-__sync_synchronize-__sync_bool_.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-Add-__builtin_stpcpy-__sync_synchronize-__sync_bool_.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 60fe1c5011209ff8ea35ba76d3993d0b345f237b Mon Sep 17 00:00:00 2001
From: Frederic Crozat <fcrozat@suse.com>
Date: Fri, 23 Mar 2012 10:31:01 +0100
Subject: [PATCH] Add __builtin_stpcpy, __sync_synchronize,
 __sync_bool_compare_and_swap to declare_builtin_functions

---
 lib.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index 396e9f1..b61a79f 100644
--- a/lib.c
+++ b/lib.c
@@ -682,6 +682,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strspn(const char *, const char *);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strcspn(const char *, const char *);\n");
 	add_pre_buffer("extern char * __builtin_strpbrk(const char *, const char *);\n");
+	add_pre_buffer("extern char* __builtin_stpcpy(const char *, const char*);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_strlen(const char *);\n");
 
 	/* And bitwise operations.. */
@@ -714,6 +715,8 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
 	add_pre_buffer("extern long __builtin_labs(long);\n");
 	add_pre_buffer("extern double __builtin_fabs(double);\n");
+	add_pre_buffer("extern void __sync_synchronize();\n");
+	add_pre_buffer("extern int __sync_bool_compare_and_swap(void *, void, void);\n");
 
 	/* Add Blackfin-specific stuff */
 	add_pre_buffer(
-- 
1.7.7


--=-J+k8viTxJt5JqCGVyafh--

