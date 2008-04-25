From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: confusing shift warning
Date: Fri, 25 Apr 2008 16:37:29 +0300
Message-ID: <e51f66da0804250637i4dff4c64p9d22a1162df14eb4@mail.gmail.com>
References: <e51f66da0804250053x2ec991dbu9a5a54fdcbea2a2a@mail.gmail.com>
	 <33544769883882222@unknownmsgid>
	 <e51f66da0804250134g7f05cc8fp9011d508f49295e3@mail.gmail.com>
	 <e51f66da0804250158o333eb371nbc0f810076c274cb@mail.gmail.com>
	 <-3423297637585954490@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:3050 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025AbYDYNhb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Apr 2008 09:37:31 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1439425nfb.21
        for <linux-sparse@vger.kernel.org>; Fri, 25 Apr 2008 06:37:30 -0700 (PDT)
In-Reply-To: <-3423297637585954490@unknownmsgid>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On 4/25/08, Pavel Roskin <proski@gnu.org> wrote:
> Quoting Marko Kreen <markokr@gmail.com>:
> > Patch attached.
>
>  NACK.  $m64 is only set if "-m64" was explicitly passed to cgcc.
>
>  It looks like cgcc code expect sparse to handle it, and sparse expects it
> from cgcc.

Do you mean the variables are not set?  But they are:

  my $m32 = 0;
  my $m64 = 0;

Or do you mean I cannot assume one of them as set, unless
overrided on command line?  But other sections (spact, i86, ppc)
do exactly that?

Or do you mean I cannot give extra -mXX arguement unless given by user?
But as you said, sparse (by policy) wont follow platform default,
but I want cgcc to follow it.  How do I achieve that then?

-- 
marko
