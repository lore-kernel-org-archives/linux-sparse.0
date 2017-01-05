From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Handle SForced in storage_modifiers
Date: Thu, 5 Jan 2017 07:39:48 +0100
Message-ID: <20170105063947.GA9300@macpro.local>
References: <1479150736-28392-1-git-send-email-jlayton@redhat.com>
 <20161114200447.GA15866@macbook.local>
 <CA+55aFxbn+ZAyN9zzcEF60UPoRN2hq86LHk9v5ecqg-c+x3pNw@mail.gmail.com>
 <CANeU7Q=p=kcHCZ2uupc+7e_Gg5uYpe2b2aoS+8nAwyK+jxLtqw@mail.gmail.com>
 <1479175640.7928.1.camel@redhat.com>
 <CANeU7Qn_hebujogeF-HEaDsSWbEaPJTDpSUR5bXG1t1r7MihXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36819 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbdAEGjz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 5 Jan 2017 01:39:55 -0500
Received: by mail-wj0-f194.google.com with SMTP id j10so78120557wjb.3
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 22:39:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn_hebujogeF-HEaDsSWbEaPJTDpSUR5bXG1t1r7MihXA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Layton <jlayton@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 17, 2016 at 06:28:15AM +0800, Christopher Li wrote:
> On Tue, Nov 15, 2016 at 10:07 AM, Jeff Layton <jlayton@redhat.com> wrote:
> >
> > That looks fine to me. If you want to merge that one, then:
> >
> > Reviewed-by: Jeff Layton <jlayton@redhat.com>
> 
> The patches is applied on "chrisl" repo and pushed out.
> 
> Actually I want to merge the patch having you as the author.
> 
> Chris
> --


I just noticed now, while doing some merging, that what have been commited
on the master tree is not the patch discussed here.
What have been commited is the same change but with 'CMax' (integer class)
while it was supposed to be 'SMax' (for the array of specifier).
The version on sparse-next is correct though.

Here is a patch fixing this:

From 04ffa624446bda7fbbc2c98fa012cb6e4bac1c53 Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 5 Jan 2017 07:31:46 +0100
Subject: [PATCH] fix mixup in "Handle SForced in storage_modifiers"

The patch used the wrong enum for the maximum size of the array.

Fixes: 1db3b627 ("Handle SForced in storage_modifiers")
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse.c b/parse.c
index b52c6abe..385e40ce 100644
--- a/parse.c
+++ b/parse.c
@@ -105,11 +105,11 @@ enum {
 };
 
 enum {
-	CInt = 0, CSInt, CUInt, CReal, CChar, CSChar, CUChar, CMax,
+	CInt = 0, CSInt, CUInt, CReal, CChar, CSChar, CUChar,
 };
 
 enum {
-	SNone = 0, STypedef, SAuto, SRegister, SExtern, SStatic, SForced
+	SNone = 0, STypedef, SAuto, SRegister, SExtern, SStatic, SForced, SMax,
 };
 
 static struct symbol_op typedef_op = {
@@ -1281,7 +1281,7 @@ static const char *storage_class[] =
 
 static unsigned long storage_modifiers(struct decl_state *ctx)
 {
-	static unsigned long mod[CMax] =
+	static unsigned long mod[SMax] =
 	{
 		[SAuto] = MOD_AUTO,
 		[SExtern] = MOD_EXTERN,
-- 
2.11.0

