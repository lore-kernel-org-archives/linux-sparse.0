From: Rob Taylor <rob.taylor@codethink.co.uk>
Subject: Re: License Questions
Date: Fri, 07 Sep 2007 16:24:39 +0100
Message-ID: <46E16D37.3020901@codethink.co.uk>
References: <1189144403.7105.13.camel@localhost> <46E13EE8.5050508@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 208-78-103-131.slicehost.net ([208.78.103.131]:56984 "EHLO
	mail.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbXIGPUs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 7 Sep 2007 11:20:48 -0400
In-Reply-To: <46E13EE8.5050508@codethink.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mathias Hasselmann <mathias.hasselmann@gmx.de>
Cc: linux-sparse@vger.kernel.org, torvalds@linux-foundation.org

Rob Taylor wrote:
> Mathias Hasselmann wrote:
>> Hello,
>>
>> Sparse uses The Open Software License v. 1.1 which contains this clause:
>>
>>         9) Acceptance and Termination. If You distribute copies of the
>>         Original Work or a Derivative Work, You must make a reasonable
>>         effort under the circumstances to obtain the express and
>>         volitional assent of recipients to the terms of this License.
>>
>> What does this mean for hosting a public git repository[1] to organize
>> sparse patches? Do I have to put some "Accept License" page in front 
>> of it? How do I force git to show that "Accept License" page when
>> downloading from that repository? 
>>
>> What does this clause mean for sending patches to the mailing list. 
>> Shouldn't the patches be attached as password protected source archive
>> and the message contain something like "By extracting that archive you
>> declare to obey the terms of The Open Software License"?
>>
>> Maybe that password thing is a solution for making git repositories 
>> OSL compliant?
> 
> Oh dear, I just found out that Debian considers OSL 1.1 non-free, though
> not for this clause (which does seem particularly onerous), but for
> clause 10.
> 
> That could be a problem for us GLib guys, as that would force gnome into
> contrib!

FWIW, OSL 3.0 [1] is a lot more sane, but I'd guess relicensing is not
an option for sparse due to Transmeta holding some copyright.

An option for us glib guys would be to mandate only using sparse at make
dist time, I *think* that'd allow libraries using it to be considered
for 'main'

Thanks,
Rob

> Rob
> 
>> Thank you,
>> Mathias
>>
>> [1] http://taschenorakel.de/git/sparse
> 
> 


-- 
Rob Taylor, Codethink Ltd. -  http://codethink.co.uk
