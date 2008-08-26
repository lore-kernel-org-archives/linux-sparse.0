From: "Alexander Shishkin" <alexander.shishckin@gmail.com>
Subject: Re: [PATCH] don't call sparse when called to generate dependencies
Date: Tue, 26 Aug 2008 12:19:07 +0300
Message-ID: <71a0d6ff0808260219k25771d4yf5ca6deceea60fbe@mail.gmail.com>
References: <1219700019-19627-1-git-send-email-alexander.shishckin@gmail.com>
	 <1219736666.21663.12.camel@spike.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:55451 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbYHZJTI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Aug 2008 05:19:08 -0400
Received: by an-out-0708.google.com with SMTP id d40so296429and.103
        for <linux-sparse@vger.kernel.org>; Tue, 26 Aug 2008 02:19:07 -0700 (PDT)
In-Reply-To: <1219736666.21663.12.camel@spike.firmix.at>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: sparse development list <linux-sparse@vger.kernel.org>

On Tue, Aug 26, 2008 at 10:44 AM, Bernd Petrovitsch <bernd@firmix.at> wrote:
> I (obviously) don't know any details about your situation but do you
> have any specific reason that you have different sets of -I/-D
> parameters on dependency generation and the real compile run?
To put a long story short: I run sparse against netbsd tree. To be
slightly more elaborate, I should mention that I wasn't able so far to
fully appreciate the beauty and elegance of certain design decisions
of the project in question. Nevertheless, I'm seeing different reports
from gendep and compilation runs.

> Personally I see only subtle problems on the horizon with such a
> situation.
> Let alone that it is somewhat simpler to have *one* CFLAGS/CPPFLAGS/...
> variable and use that everywhere.
Well, that aside, the overall build time significantly increases with
having to run sparse twice. Same warnings/errors are reported twice.

I still think that sparse has no business validating any code when
cgcc is called in -M mode; all those files are going to be compiled
later on anyway. And it's the compilation stage where warnings are
desirable.

Regards,
--
Alex
