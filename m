From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v1 01/28] misc: fix testcase typeof-safe
Date: Wed, 20 May 2020 18:12:59 +0200
Message-ID: <20200520161259.u4raoc4bujauzu5y@ltop.local>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-2-luc.vanoostenryck@gmail.com>
 <422723ea-00aa-ee89-72aa-f4dddbd8da06@ramsayjones.plus.com>
 <2de08a4e-ce53-8694-da00-c2c90334da65@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETQNC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 May 2020 12:13:02 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCB7C061A0E
        for <linux-sparse@vger.kernel.org>; Wed, 20 May 2020 09:13:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id bs4so3650746edb.6
        for <linux-sparse@vger.kernel.org>; Wed, 20 May 2020 09:13:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2de08a4e-ce53-8694-da00-c2c90334da65@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Wed, May 20, 2020 at 04:34:53PM +0100, Ramsay Jones wrote:
> On 20/05/2020 01:33, Ramsay Jones wrote:
> > On 19/05/2020 01:57, Luc Van Oostenryck wrote:
> >> +	int __safe  var3 = obj;
> >> +	int *ptr4 = &obj;
> >> +	int *ptr4 = ptr;		// KO
> > 
> > ptr4 declared twice - and sparse didn't complain?

Yes, I was surprised by this too.
 
> Heh, I had a slightly different example in the test case
> for my '{0}' initializer patch (but involving different
> types as well).
> 
> I had a quick look at this and tried to use 'git-bisect' to
> isolate the change which broke this. However, I couldn't find
> a version of sparse that worked correctly! :D (I went all the
> way back to v0.4.2 before giving up - several tagged releases
> didn't even compile without some fix-ups, including v0.4.2).

Yes, it's quite annoying when bisecting, but well ...
 
> Just FYI, this was my test-case:
> 
>   $ cat -n test-dup-decl.c
>        1	#ifdef WORKS_OK
>        2	static int sobj;
>        3	static int *sptr4 = &sobj;
>        4	static int *sptr4 = 0;
>        5	#endif
>        6	
>        7	static void func(void)
>        8	{
>        9		int obj, *ptr;
>       10		int *ptr4 = &obj;
>       11		int *ptr4 = ptr;
>       12		int a;
>       13		float a;
>       14	}
>   $ 
> 
>   $ gcc -c test-dup-decl.c
>   test-dup-decl.c: In function ‘func’:
>   test-dup-decl.c:11:7: error: redefinition of ‘ptr4’
>     int *ptr4 = ptr;
>          ^~~~
>   test-dup-decl.c:10:7: note: previous definition of ‘ptr4’ was here
>     int *ptr4 = &obj;
>          ^~~~
>   test-dup-decl.c:13:8: error: conflicting types for ‘a’
>     float a;
>           ^
>   test-dup-decl.c:12:6: note: previous declaration of ‘a’ was here
>     int a;
>         ^
>   $ 
> 
>   $ ./sparse test-dup-decl.c
>   $ 

It seems that sparse detect the redefinition when the symbols are global
but not when they're local.

Thanks for noticing this.
-- Luc
