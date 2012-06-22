From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: buffer overflow check bug
Date: Fri, 22 Jun 2012 15:31:54 +0300
Message-ID: <20120622123154.GA5333@mwanda>
References: <4FDF0AA5.6080905@gmail.com>
 <20120618113037.GI4400@mwanda>
 <4FDF1610.3000100@gmail.com>
 <20120618121726.GG13539@mwanda>
 <4FDF2036.4080908@gmail.com>
 <20120618134338.GJ4400@mwanda>
 <20120618181111.GH13539@mwanda>
 <CAHGf_=rNSUKPrV5yYyJ8KWbvHO4zAPU7Du4_9HbwW-HiLVbFiw@mail.gmail.com>
 <20120618195344.GM4400@mwanda>
 <EA6DE3B9-8977-4135-89F0-34812CCE9FF6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:18893 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823Ab2FVMcS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Jun 2012 08:32:18 -0400
Content-Disposition: inline
In-Reply-To: <EA6DE3B9-8977-4135-89F0-34812CCE9FF6@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@gmail.com>, smatch@vger.kernel.org, linux-sparse@vger.kernel.org

On Tue, Jun 19, 2012 at 04:37:20PM -0400, Xi Wang wrote:
> On Jun 18, 2012, at 3:53 PM, Dan Carpenter wrote:
> 
> > Gar...  I have no idea.  That seems like an issue in sparse.
> > 
> > Does anyone know why MOD_NORETURN gets set for:
> > extern void my_exit(const char*, ...) __attribute__ ((__noreturn__));
> > 
> > but not for:
> > extern __attribute__ ((__noreturn__)) void my_exit(const char*, ...);
> > 
> > GCC seems to accept both formats.
> 
> Which version of sparse are you using?  Everything looks good to me here.

I'm on sparse 0.4.4.  Which version are you on?

> 
>   extern void my_exit(const char*, ...) __attribute__ ((__noreturn__));
>   extern __attribute__ ((__noreturn__)) void another_exit(const char*, ...);
>   void foo(void) { my_exit(""); }
>   void bar(void) { another_exit(""); }
> 
> My backend "splay" emits:
> 
>   declare void @my_exit(i8*, ...) noreturn
>   declare void @another_exit(i8*, ...) noreturn
>   ...
> 
> The noreturn attribute is set simply by:
> 
>   if (sym->ctype.modifiers & MOD_NORETURN)
>       LLVMAddFunctionAttr(func, LLVMNoReturnAttribute);

Yep.  I use the same test, but sym->ctype.modifiers is not set for
me. The debug printf I added in handle_attributes() should have
printed.

regards,
dan carpenter
