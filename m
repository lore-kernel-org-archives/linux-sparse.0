From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: label 'continue' already bound, unreplaced symbol 'return'
Date: Fri, 22 Feb 2008 11:16:39 -0800
Message-ID: <70318cbf0802221116i229152d1wafc15442cd0ab2d3@mail.gmail.com>
References: <1202948215.8941.37.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:10453 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbYBVTQl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Feb 2008 14:16:41 -0500
Received: by rv-out-0910.google.com with SMTP id k20so328277rvb.1
        for <linux-sparse@vger.kernel.org>; Fri, 22 Feb 2008 11:16:39 -0800 (PST)
In-Reply-To: <1202948215.8941.37.camel@dv>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

>  static inline int foo(void)
>  {
>     do {
>     } while (0);
>     return 0;
>  }
>  int bar(void);
>  int bar(void)
>  {
>     return foo();
>  }
>  typeof(bar) quux;
>
>
>  hal.c:12:13: warning: symbol 'quux' was not declared. Should it be
>  static?
>  hal.c:3:5: warning: label 'continue' already bound
>  hal.c:3:5: warning: label 'break' already bound

This happen because you try to make quux has type of *function*,
not a function pointer. Sparse literary assign the base type of bar
as base  type of quux. This result in body of bar get linearized twice.

I don't thing typeof(bar) quux is doing any thing useful.
I am not sure what is the gcc rules here. I try gcc -S with the test
case, it does not even generate any thing for quux.

The rest of the test case is more or less the same thing.

>  "extern" before "typeof" fixes all warnings.

That is because, once you declear it as "extern", it does not emit
any code.

I guess I can skip typeof(function) to fix it, like gcc does. Is there
better suggestions?

Chris
