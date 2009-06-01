From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH 1/3] Add -*- gdb-script -*- to the top of gdbhelpers, for
	Emacs
Date: Mon, 1 Jun 2009 13:36:59 -0400
Message-ID: <db65a1cd0906011036t6b83a97v38664b7d7ba06f51@mail.gmail.com>
References: <1243784652-31802-1-git-send-email-naesten@gmail.com>
	 <f19298770905312321q6eedf6e8ge7d5fe5ec46740da@mail.gmail.com>
	 <db65a1cd0906010906x5e3b0044j181159e627b80800@mail.gmail.com>
	 <5b5833aa0906011026p11eacb23y2f8326312a61fc22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:63350 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbZFARg6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 1 Jun 2009 13:36:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so16022881and.1
        for <linux-sparse@vger.kernel.org>; Mon, 01 Jun 2009 10:36:59 -0700 (PDT)
In-Reply-To: <5b5833aa0906011026p11eacb23y2f8326312a61fc22@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Anderson Lizardo <anderson.lizardo@gmail.com>
Cc: Alexey Zaytsev <alexey.zaytsev@gmail.com>, linux-sparse@vger.kernel.org

On Mon, Jun 1, 2009 at 1:26 PM, Anderson Lizardo
<anderson.lizardo@gmail.com> wrote:
> On Mon, Jun 1, 2009 at 12:06 PM, Samuel Bronson <naesten@gmail.com> wrote:
>> I just don't feel comfortable contributing under the OSL 1.1, for some
>> reason -- possibly because it's considered non-DFSG, possibly because
>> it's even more restrictive than the GPL ...
>
> If you look at the recent mailing list archives, you will find that a
> particular snapshot of the git tree was relicensed by the original
> copyright holder (Transmeta?) under the MIT license. It seems the
> current developers intend to check with the other copyright holders
> (for code commited after the particular relicensed snapshot) for a
> license change.
>
> So I would you suggest at least using the MIT license to not "pollute"
> the code with yet another license...

Oh, sure, that's fine with me! Hadn't heard about that. The MIT/X11
license is almost the same as the ISC license. Go ahead and s/ISC
license/MIT license/ in these patches, though I don't think either of
the patches that actually work (1/3 and 3/3) give me copyright on any
code anyway.
