From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: [PATCH] don't call sparse when called to generate dependencies
Date: Tue, 26 Aug 2008 12:00:47 +0200
Message-ID: <1219744847.21663.34.camel@spike.firmix.at>
References: <1219700019-19627-1-git-send-email-alexander.shishckin@gmail.com>
	 <1219736666.21663.12.camel@spike.firmix.at>
	 <71a0d6ff0808260219k25771d4yf5ca6deceea60fbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns.firmix.at ([62.141.48.66]:3587 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410AbYHZKAz (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Aug 2008 06:00:55 -0400
Received: from ns.firmix.at (localhost [127.0.0.1])
	by ns.firmix.at (8.14.1/8.14.1) with ESMTP id m7QA0qrR007104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Tue, 26 Aug 2008 12:00:52 +0200
Received: (from defang@localhost)
	by ns.firmix.at (8.14.1/8.14.1/Submit) id m7QA0mFK007101
	for <linux-sparse@vger.kernel.org>; Tue, 26 Aug 2008 12:00:48 +0200
In-Reply-To: <71a0d6ff0808260219k25771d4yf5ca6deceea60fbe@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexander Shishkin <alexander.shishckin@gmail.com>
Cc: sparse development list <linux-sparse@vger.kernel.org>


On Tue, 2008-08-26 at 12:19 +0300, Alexander Shishkin wrote:
> On Tue, Aug 26, 2008 at 10:44 AM, Bernd Petrovitsch <bernd@firmix.at> wrote:
[....]
> > Let alone that it is somewhat simpler to have *one* CFLAGS/CPPFLAGS/...
> > variable and use that everywhere.
> Well, that aside, the overall build time significantly increases with
> having to run sparse twice. Same warnings/errors are reported twice.

Of course (and especially on a large source tree).

> I still think that sparse has no business validating any code when
> cgcc is called in -M mode; all those files are going to be compiled

Yes, that also seems superflous to me in general.

> later on anyway. And it's the compilation stage where warnings are
> desirable.

ACK.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


