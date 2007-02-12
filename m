From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Another sparse warning...
Date: Mon, 12 Feb 2007 15:55:46 +0000
Message-ID: <BA2EBAD3-5474-44C5-B93B-34A40A8A0722@cam.ac.uk>
References: <4975FCBA-D3D4-4DF2-AC20-C11A5F97DE51@cam.ac.uk> <Pine.LNX.4.64.0702120742030.8424@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:52686 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933034AbXBLP4m (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 10:56:42 -0500
In-Reply-To: <Pine.LNX.4.64.0702120742030.8424@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org

Hi Linus,

On 12 Feb 2007, at 15:50, Linus Torvalds wrote:
> On Mon, 12 Feb 2007, Anton Altaparmakov wrote:
>>
>> What can I do to tell sparse that this code is ok and there should  
>> not be a
>> warning?  Is there a "__ignore_context_imbalance" or something  
>> that I can mark
>> up the {un,}lock_kernel() with or something like that?
>
> No, you should annotate the function as already having the lock when
> entered.
[snip]
> 	int myfunction(..)
> 		__releases(kernel_lock)
> 		__acquires(kernel_lock)
> 	{
> 		unlock_kernel();
> 		..
> 		lock_kernel();
> 	}

Great, thanks!  That works a treat. (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
