From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: confusing shift warning
Date: Fri, 25 Apr 2008 11:34:58 +0300
Message-ID: <e51f66da0804250134g7f05cc8fp9011d508f49295e3@mail.gmail.com>
References: <e51f66da0804250053x2ec991dbu9a5a54fdcbea2a2a@mail.gmail.com>
	 <33544769883882222@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:10715 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756936AbYDYIfF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Apr 2008 04:35:05 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1405670nfb.21
        for <linux-sparse@vger.kernel.org>; Fri, 25 Apr 2008 01:34:58 -0700 (PDT)
In-Reply-To: <33544769883882222@unknownmsgid>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On 4/25/08, Pavel Roskin <proski@gnu.org> wrote:
> Quoting Marko Kreen <markokr@gmail.com>:
>
>
> > Platform: x64_64 linux, uint64_t -> unsigned long
> > Sparse: today's git (6dcc36a)
> >
>  ...
>
> > Guess - somewhere is hardwired that "long" == "32-bit"?
> >
>
>  Of course not.  But -m64 should be specified to enable 64-bit type sizes.
>
>
> > For reference:
> > $ cgcc -v -c test.c
> > sparse -v -c test.c -Dx86_64=1 -D__x86_64=1 -D__x86_64__=1
> >
>  ...
>
>  cgcc fails to add -m64.  It must be a bug in cgcc.  This would not produce
> the warning:
>
>  cgcc -m64 -no-compile Test.c

Ok, that somewhat explains it.  But:

    } elsif ($spec eq 'x86_64') {
        return (' -Dx86_64=1 -D__x86_64=1 -D__x86_64__=1' .
                &integer_types (8, 16, 32, $m32 ? 32 : 64, 64) .
                &float_types (1, 1, 33, [24,8], [53,11], [113,15]) .
                &define_size_t ($m32 ? "unsigned int" : "long unsigned int"));

It seems that cgcc defaults to 64-bit on x86_64, but sparse to 32-bit.
Isn't it sparse bug then?  Shouldnt it follow platform defaults?

-- 
marko
