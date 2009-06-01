From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 1/3] Add -*- gdb-script -*- to the top of gdbhelpers, for
	Emacs
Date: Mon, 1 Jun 2009 21:44:58 +0400
Message-ID: <f19298770906011044o3affa20agc84787cfd9752618@mail.gmail.com>
References: <1243784652-31802-1-git-send-email-naesten@gmail.com>
	 <f19298770905312321q6eedf6e8ge7d5fe5ec46740da@mail.gmail.com>
	 <db65a1cd0906010906x5e3b0044j181159e627b80800@mail.gmail.com>
	 <5b5833aa0906011026p11eacb23y2f8326312a61fc22@mail.gmail.com>
	 <db65a1cd0906011036t6b83a97v38664b7d7ba06f51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:62499 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZFARo5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 1 Jun 2009 13:44:57 -0400
Received: by fxm12 with SMTP id 12so5950278fxm.37
        for <linux-sparse@vger.kernel.org>; Mon, 01 Jun 2009 10:44:58 -0700 (PDT)
In-Reply-To: <db65a1cd0906011036t6b83a97v38664b7d7ba06f51@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Samuel Bronson <naesten@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@gmail.com>, linux-sparse@vger.kernel.org

On Mon, Jun 1, 2009 at 21:36, Samuel Bronson <naesten@gmail.com> wrote:
> On Mon, Jun 1, 2009 at 1:26 PM, Anderson Lizardo
> <anderson.lizardo@gmail.com> wrote:
>> On Mon, Jun 1, 2009 at 12:06 PM, Samuel Bronson <naesten@gmail.com> wrote:
>>> I just don't feel comfortable contributing under the OSL 1.1, for some
>>> reason -- possibly because it's considered non-DFSG, possibly because
>>> it's even more restrictive than the GPL ...
>>
>> If you look at the recent mailing list archives, you will find that a
>> particular snapshot of the git tree was relicensed by the original
>> copyright holder (Transmeta?) under the MIT license. It seems the
>> current developers intend to check with the other copyright holders
>> (for code commited after the particular relicensed snapshot) for a
>> license change.
>>
>> So I would you suggest at least using the MIT license to not "pollute"
>> the code with yet another license...
>
> Oh, sure, that's fine with me! Hadn't heard about that. The MIT/X11
> license is almost the same as the ISC license. Go ahead and s/ISC
> license/MIT license/ in these patches, though I don't think either of
> the patches that actually work (1/3 and 3/3) give me copyright on any
> code anyway.
>

Won't work that easily. Only an early sparse version, owned exclusively
by transmeta may be alternatively distribute under the MIT license. To
convert the current sparse version to MIT, we need to get all the
contributors to agree to this. Not impossible, but someone needs to
send lots of emails. ;)
