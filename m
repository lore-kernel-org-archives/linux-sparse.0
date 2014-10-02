From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 06/10] don't run sparse{c,i} tests when sparse-llvm is
 disabled
Date: Thu, 02 Oct 2014 11:31:48 +0100
Message-ID: <542D2994.7020304@ramsay1.demon.co.uk>
References: <53DFD320.2050903@ramsay1.demon.co.uk>	<CANeU7QkFPTW04ECjrJKHO51g38R6r3Rt8jX74PsAnEgpxRqxYw@mail.gmail.com>	<5426BD97.2080700@ramsay1.demon.co.uk>	<CANeU7Q=vDAuBwWqy0=rbvkpgmzysCw=pfSEcwzyRRSZj3QrJbA@mail.gmail.com> <CANeU7QnXWFad9Re0MtGkei6F6ZnUOH96et5_7aJQommFp2dLwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:45600 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbaJBKbv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Oct 2014 06:31:51 -0400
In-Reply-To: <CANeU7QnXWFad9Re0MtGkei6F6ZnUOH96et5_7aJQommFp2dLwQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 02/10/14 04:44, Christopher Li wrote:
> On Tue, Sep 30, 2014 at 11:26 AM, Christopher Li <sparse@chrisli.org> wrote:
>> I am thinking some thing in the test-suite like:
>>
>> set_deps sparsec sparse-llvm
>> set_deps sparsei sparse-llvm
>>
>> ...
>> get_deps `basename cmd`
>> dep_cmd=$last_result
> 
> Actually, I try that, it is a little bit too complicated.
> 
> Your first approach is fine.
> 
> I end up using your V1 patch, with a small change to do exact match rather than
> a wild cast. The wild cast has danger that match a sub word of the command.
> e.g. if you try to disable command "sp", it will disable "sparse" as well.

Ah yes, good catch!

ATB,
Ramsay Jones



