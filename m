From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Thu, 31 Aug 2017 23:43:53 +0100
Message-ID: <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:47663 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbdHaWn6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Aug 2017 18:43:58 -0400
In-Reply-To: <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>, Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>



On 31/08/17 21:55, Uwe Kleine-König wrote:
> On Wed, Aug 30, 2017 at 08:11:49PM -0400, Christopher Li wrote:
>> That is very much like on x86_64 missing define "#weak_define __x86_64__ 1"
>>
>> Does cgcc work for you? In the future we do want to move the archetecture
>> related define from cgcc into sparse by itself. For now you can set
>> "sparse" as "cgcc -no-compile"
> 
> Yes that works. So to address the Debian bug I can do:
> 
>  - move sparse to /usr/lib
>  - teach cgcc about the move of sparse
>  - make /usr/bin/sparse call cgcc -no-compile "$@"

Hmm, I don't think that would be a good idea ...

> or is it easier to teach sparse about the architecture stuff?

I now understand (I think!) that you are building a sparse
package (presumably a .deb) and you are concerned that sparse
does not pass it's own testsuite on those platforms.

As I said before, the additional failures you are seeing are
in the 'llvm backend' code (which, as far as I know, only passes
on x86_64 Linux), and in my opinion the llvm-backend programs should
not be installed. (The Makefile will build them automatically if
you have llvm installed, likewise for c2xml/libxml and test-inspect/gtk).

[I would like to see build variable(s) to allow the user to suppress
the build (or installation) of the other 'non-primary' sparse programs.]

Anyway, if you were to un-install llvm, sparse-llvm etc., would not
be built, and the tests would not be run ... ;-)

Christopher, as the project maintainer, has the joy of making these
kinds of decisions! :-D

ATB,
Ramsay Jones

