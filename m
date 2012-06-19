From: Xi Wang <xi.wang@gmail.com>
Subject: Re: buffer overflow check bug
Date: Tue, 19 Jun 2012 16:37:20 -0400
Message-ID: <EA6DE3B9-8977-4135-89F0-34812CCE9FF6@gmail.com>
References: <4FDBA56F.8070106@gmail.com> <4FDEFCB1.7030800@gmail.com> <4FDF0AA5.6080905@gmail.com> <20120618113037.GI4400@mwanda> <4FDF1610.3000100@gmail.com> <20120618121726.GG13539@mwanda> <4FDF2036.4080908@gmail.com> <20120618134338.GJ4400@mwanda> <20120618181111.GH13539@mwanda> <CAHGf_=rNSUKPrV5yYyJ8KWbvHO4zAPU7Du4_9HbwW-HiLVbFiw@mail.gmail.com> <20120618195344.GM4400@mwanda>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47688 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab2FSUh1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Jun 2012 16:37:27 -0400
In-Reply-To: <20120618195344.GM4400@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@gmail.com>, smatch@vger.kernel.org, linux-sparse@vger.kernel.org

On Jun 18, 2012, at 3:53 PM, Dan Carpenter wrote:

> Gar...  I have no idea.  That seems like an issue in sparse.
> 
> Does anyone know why MOD_NORETURN gets set for:
> extern void my_exit(const char*, ...) __attribute__ ((__noreturn__));
> 
> but not for:
> extern __attribute__ ((__noreturn__)) void my_exit(const char*, ...);
> 
> GCC seems to accept both formats.

Which version of sparse are you using?  Everything looks good to me here.

  extern void my_exit(const char*, ...) __attribute__ ((__noreturn__));
  extern __attribute__ ((__noreturn__)) void another_exit(const char*, ...);
  void foo(void) { my_exit(""); }
  void bar(void) { another_exit(""); }

My backend "splay" emits:

  declare void @my_exit(i8*, ...) noreturn
  declare void @another_exit(i8*, ...) noreturn
  ...

The noreturn attribute is set simply by:

  if (sym->ctype.modifiers & MOD_NORETURN)
      LLVMAddFunctionAttr(func, LLVMNoReturnAttribute);

- xi
