From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: Sparse and the Google Summer of Code 2008
Date: Wed, 12 Mar 2008 01:41:22 +0000
Message-ID: <47D734C2.1020903@knosof.co.uk>
References: <f19298770803111038o3655a216vfe5a4b46876e7218@mail.gmail.com> <47D6CD7F.6010800@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from queueout01-winn.ispmail.ntl.com ([81.103.221.31]:59902 "EHLO
	queueout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751059AbYCLBvb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Mar 2008 21:51:31 -0400
In-Reply-To: <47D6CD7F.6010800@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

Josh,

>> I know, last year was not all that successful, but maybe
>> there will be more applications this year. I've got some
>> ideas about abstract interpretation for one. I can't promise
>> that I'll choose sparse, there should be lots of interesting
>> projects this year, but there are other people as well.
> 
> At least one other person has asked about Sparse and SoC, which
> suggests that some interest exists.  I'll work on getting the
> org forms filled out today.
> 
> If anyone else on the Sparse list has an interest in mentoring, please
> let me know as soon as possible.

The ideas so far proposed are major undertakings.  The sort of
thing a summer student will only scratch the surface of.

I think it would be useful to analyze the Linux bug history,
looking for known faults and their fixes, that are currently not
detected by Sparse, but which look like they are amenable to static
detection.
If more faults are required there is always the BSD bug list.

If the existing faults were categorized it would give some idea
of the kinds of constructs that ought to be searched for.

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
