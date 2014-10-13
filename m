From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/4] chrisl master branch patches
Date: Mon, 13 Oct 2014 23:58:53 +0100
Message-ID: <543C592D.50807@ramsay1.demon.co.uk>
References: <54398B23.8080501@ramsay1.demon.co.uk> <CANeU7QnDim5JuSO5HBgBgwUVu1cGDyBwcAKUTVY-vQKjfrBiLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:54727 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751343AbaJMW65 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 13 Oct 2014 18:58:57 -0400
In-Reply-To: <CANeU7QnDim5JuSO5HBgBgwUVu1cGDyBwcAKUTVY-vQKjfrBiLw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 12/10/14 10:22, Christopher Li wrote:
> On Sun, Oct 12, 2014 at 3:55 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:

[snip]

>> The final patch is a possible alternative to "[PATCH 04/10]
>> compile-i386.c: don't mix calls to write(2) with stdio", which
>> basically just removes the compile program. If you prefer
>> another solution, just let me know.
> 
> I think I would just keep it as example of using the sparse
> front end AST. For compiling, the sparse-llvm does a better job
> there.
> 

OK, I will send an alternative patch separately (directly after this).

ATB,
Ramsay Jones



