From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 1/2] evaluate: split out implementation of compatible_assignment_types
Date: Tue, 01 Apr 2014 15:31:11 +0100
Message-ID: <533ACDAF.6050408@ramsay1.demon.co.uk>
References: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1394364717.git.john@keeping.me.uk> <CANeU7Qm5pHTZCSk83ToxXqDPw4RfEaOTnE6YntQa+KEYVZUi0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:33551 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750786AbaDAOhg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Apr 2014 10:37:36 -0400
In-Reply-To: <CANeU7Qm5pHTZCSk83ToxXqDPw4RfEaOTnE6YntQa+KEYVZUi0w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, John Keeping <john@keeping.me.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 01/04/14 08:46, Christopher Li wrote:
> On Sun, Mar 9, 2014 at 4:32 AM, John Keeping <john@keeping.me.uk> wrote:
>> This will allow us to reuse the logic when processing a transparent
>> union by checking each member in turn without printing a warning unless
>> none of the members match.
> 
> Both patches applied.
> 
> Chris

I 'tested' these patches (on Linux), by running sparse over the git.git
sources, as soon as they were posted. They worked beautifully. (git.git
on Linux (32-bit) only has a single sparse warning now - yay! :)

I forgot to report that here, since I had intended to test the patches
on Cygwin and (my version of sparse) on MinGW first, but I didn't get
around to it ... sorry!  (Hmm, I may have time tonight ...)

ATB,
Ramsay Jones



