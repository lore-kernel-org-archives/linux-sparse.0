From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v6 00/15] prepare for LLVM fixes
Date: Tue, 28 Mar 2017 17:01:01 +0100
Message-ID: <59bd9f39-9f21-dc49-7ea3-8773c1db91d4@ramsayjones.plus.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
 <7406f777-5e8b-5ae0-55e0-26a36ddb64b5@ramsayjones.plus.com>
 <20170327222212.jle5tzjevfsigvuw@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:56150 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753384AbdC1QB2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 12:01:28 -0400
In-Reply-To: <20170327222212.jle5tzjevfsigvuw@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>



On 27/03/17 23:22, Luc Van Oostenryck wrote:
> On Mon, Mar 27, 2017 at 10:56:52PM +0100, Ramsay Jones wrote:
>> On 27/03/17 18:33, Luc Van Oostenryck wrote:
>>> This serie contains preparatory patches for
>>> sparse-llvm's fixes but not sparse-llvm specific
>>> and having some values of their own.
>>>
>>> These patches were extracted from a previous
>>> serie containing also the sparse-llvm patches.
>>>
>>> Changes since v5:
>>> - use a table for compare_opcode() & swap_compare_opcode()
>>> - fix test cases on 32bit machines
>>
>> Hmm, I assumed that this series should apply to master, and then
>> the following 52 patch series on top.
> 
> Well no, sorry.
> I haven't explained because I thought it was obvious but
> of course, it's not obvious at all.

;-)

> These series apply, and in general any patches or series I send,
> in the order I send them, on top of the stable part of sparse-next.
> And by "the stable part of sparse-next" I mean that if sparse-next
> contains serie-xyz-v2 and I sent serie-xyz-v3, the serie will apply
> at the same place that the -v2 serie was.

Hmm, OK. I assume Christopher knows what this means! So, I will wait
for Christopher to re-integrate these patches and re-write the
'sparse-next' branch in the public repository before testing again.

Thanks!

ATB,
Ramsay Jones
