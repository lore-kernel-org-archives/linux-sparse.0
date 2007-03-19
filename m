From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Sparse homepage moved; Git repository moving soon [Re: update
 'getting sparse' info.]
Date: Sun, 18 Mar 2007 18:21:31 -0700
Message-ID: <45FDE59B.6030702@zytor.com>
References: <20070309004526.GA17459@redhat.com> <45F0B45C.9060706@zytor.com> <Pine.LNX.4.64.0703091039280.10832@woody.linux-foundation.org> <45F1AD49.1080604@zytor.com> <45F73351.5080505@kernel.org> <45F7346B.6040605@zytor.com> <45FDE2A6.1090901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:49793 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbXCSBVi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 18 Mar 2007 21:21:38 -0400
In-Reply-To: <45FDE2A6.1090901@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org, ftpadmin@kernel.org

Josh Triplett wrote:
> H. Peter Anvin wrote:
>> Josh Triplett wrote:
>>> Also, if possible, I'd like to have an HTTP 301 redirect from
>>> http://kernel.org/pub/linux/kernel/people/josh/sparse (and everything under
>>> it, via RedirectMatch) to the corresponding page under the new homepage at
>>> http://kernel.org/pub/software/devel/sparse .  Could someone with the
>>> appropriate access please do so, or let me know if I can do so somehow?
>> I *think* you can just put an .htaccess file in your directory to have 
>> that happen.
> 
> That doesn't seem to work.  The .htaccess file
> (/pub/linux/kernel/people/josh/sparse/.htaccess) gets mirrored, but seems to
> get ignored.  It contains the following:
> 
> Redirect /pub/linux/kernel/people/josh/sparse http://www.kernel.org/pub/software/devel/sparse
> 

That should be fixed, but you want to change that to "Redirect permanent 
..." otherwise you get a 302 redirect, not 301.

	-hpa
