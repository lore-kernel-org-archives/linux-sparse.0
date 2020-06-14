From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [ANNOUNCE] Sparse v0.6.2-rc1
Date: Mon, 15 Jun 2020 00:37:28 +0100
Message-ID: <d540f450-c72e-5c51-ffba-32d7eb800137@ramsayjones.plus.com>
References: <20200613020735.iqb2vd23jpomisbq@ltop.local>
 <c80024d2-6d91-4fe7-a919-3edcf4a9b80a@ramsayjones.plus.com>
 <20200614215445.rtfbx23ve57fhlbr@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:43707 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgFNXhc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Jun 2020 19:37:32 -0400
In-Reply-To: <20200614215445.rtfbx23ve57fhlbr@ltop.local>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org



On 14/06/2020 22:54, Luc Van Oostenryck wrote:
> On Sun, Jun 14, 2020 at 08:35:51PM +0100, Ramsay Jones wrote:
>>
>>
>> On 13/06/2020 03:07, Luc Van Oostenryck wrote:
>>> Sparse v0.6.2-rc1 is now out.
>>
>> Tested in the usual places (Linux Mint 19.3, 64-bit and 32-bit and
>> 64-bit cygwin) and in the usual way; no issues found!
> 
> Thanks a lot. Here I tested it on 64-bit Debian (latest + unstable)
> and Ubuntu, and also on ARM64, ARM(32), ppc64, sparc64, mips64.
> I'll give a try later to some BSD.
> 
>> Well, I say no issues - I did notice some spelling errors and
>> the formatting of the release notes does not look correct to
>> me (https://sparse.docs.kernel.org/en/latest/release-notes/v0.6.2.html).
>> Unfortunately, I don't know anything about the documentation tools
>> you are using, so I can't try to fix this. (It seems to be the only
>> attempt at nested 'bulleted lists', ...)
> 
> Yes, I saw that too now. I thought I had fixed it but visibly it
> wasn't. It should be really fixed now.
> 
> [(Just FYI) The format of the doc is either reStructuredText
> (.rst) or MarkDown (.md). Both are much less simple than they
> appear to be but they have the huge advantage to almost look
> as if there is no markup at all/as if written 'naturally' in
> ASCII. Much much more readable than man-pages or html markup.
> 
> The system used to generate the resulting HTML is Sphinx.
> It has the huge advantage to be very easy to install/to have
> near-zero dependencies: it's just a single python package.
> To use it, it's enough to just 'cd Documentation; make html'

I just installed python-sphinx (on LM 19.3 it is the python2
version) to give it a try, and it failed:

  $ make html
  Running Sphinx v1.6.7
  making output directory...

  Extension error:
  Could not import extension cdoc (exception: cannot import name switch_source_input)
  Makefile:21: recipe for target 'html' failed
  make: *** [html] Error 1
  $ 

It's too late to try and fix it tonight ... (also LM 20 is currently
in beta, so I will be trading up soon) :D

ATB,
Ramsay Jones

> and the result can be found in 'build/html'. But I confess,
> most of the time, I'm too lazy to do that, I just push it
> on github which trigger a build on readthedocs.io (which
> then nicely send me an email if there is an error).]
> 
> -- Luc
> 
