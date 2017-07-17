From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: make selfcheck
Date: Mon, 17 Jul 2017 20:28:28 +0100
Message-ID: <ae7e6285-eb5b-9137-fab4-0ecc502aab7a@ramsayjones.plus.com>
References: <d5ab8af1-6a09-9985-7de1-8ad639369795@ramsayjones.plus.com>
 <39e3d856-fd32-8059-10bb-ad1367e7d7a9@ramsayjones.plus.com>
 <CANeU7QmRaS8C8AyvtduDccK_w9pOjqppbMDoEDtyNH0OnN6ikw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:42820 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdGQT2b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 15:28:31 -0400
In-Reply-To: <CANeU7QmRaS8C8AyvtduDccK_w9pOjqppbMDoEDtyNH0OnN6ikw@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 17/07/17 20:16, Christopher Li wrote:
> On Mon, Jul 17, 2017 at 2:19 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>> This should have been './cgcc -no-compile', of course. :(
>>
> Yes, of course. I discover that myself too. I am sending out a V2
> version of the patches.
> In the V2 version I move the checker command to be controlled by "$(CHECKER)".
> For example I can change CHECKER to test-linearize and get the full
> byte code output.
> 
> BTW, are you OK I merge your change with mine in the V2 patches?

yes, no problem.

I nearly have a clean 'make selfcheck' (I suspect you do too!).
I was supposed to have gone out a while ago, ... I guess I will
not get it finished before I go. :(

ATB,
Ramsay Jones


