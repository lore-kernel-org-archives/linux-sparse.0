From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: dependency tee from c parser entities downto token
Date: Sat, 05 May 2012 10:59:54 +0200
Message-ID: <4FA4EC0A.30304@gmail.com>
References: <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com> <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com> <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com> <4FA38635.5060300@gaisler.com> <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com> <4FA3B14A.3070609@gaisler.com> <4FA3CD58.80809@gmail.com> <20120504153054.GA5994@leaf> <4FA441E0.6010701@gmail.com> <CANeU7QkoHY_L9oQ4WuxPFUABwFznTfAMWMSRz7-Pe98dSiuiGQ@mail.gmail.com> <20120505003231.GA3990@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46067 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751049Ab2EEI4X (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 5 May 2012 04:56:23 -0400
Received: by lahj13 with SMTP id j13so2521345lah.19
        for <linux-sparse@vger.kernel.org>; Sat, 05 May 2012 01:56:22 -0700 (PDT)
In-Reply-To: <20120505003231.GA3990@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Konrad Eisele <konrad@gaisler.com>, linux-sparse@vger.kernel.org

On 05/05/2012 02:32 AM, Josh Triplett wrote:
> On Fri, May 04, 2012 at 03:30:21PM -0700, Christopher Li wrote:
>> On Fri, May 4, 2012 at 1:53 PM, Konrad Eisele<eiselekd@gmail.com>  wrote:
>>> make C=2:
>>>
>>> original sparse:
>>> real    17m54.997s
>>> user    15m25.181s
>>> sys     2m11.281s
>>>
>>> decpp-sparse from "git clone git://git.code.sf.net/p/decpp/code decpp "
>>> real    18m29.748s
>>> user    16m18.155s
>>> sys     2m13.221s
>>>
>>> But decpp is not written with performance in common cases in mind.
>>> The 2 runs probably also depend on other factors too.
>>> I cant think that 4 bytes extra for each token can have a big impact,
>>> if I would implement it that way (it is not in decpp).
>>
>> The deal breaker is not able to free token list if other program using
>> sparse don't need it.
>
>> From the top of token.h:
>
> /*
>   * Basic tokenization structures. NOTE! Those tokens had better
>   * be pretty small, since we're going to keep them all in memory
>   * indefinitely.
>
> Has that changed?  If so, perhaps the comment needs fixing.  If not, I
> suspect the problem lies elsewhere; perhaps in the extra levels of
> indirection introduced by the patch, rather than in the extra memory
> usage.

The benchmarking of decpp's sparse is not based on the patch I sent,
rather decpp's sparse does a lot more tagging to every token with a lot
of extra data. And without performance in mind.Programmed with the
common cases performance in mind it shouldnt have an impact at all...
I think I understood Christophers suggestion now and migh implement
it that way..
-- Konrad



>
> - Josh Triplett
>

