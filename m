From: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: [PATCH] don't call sparse when called to generate dependencies
Date: Tue, 26 Aug 2008 09:44:26 +0200
Message-ID: <1219736666.21663.12.camel@spike.firmix.at>
References: <1219700019-19627-1-git-send-email-alexander.shishckin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ns.firmix.at ([62.141.48.66]:3173 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbYHZHoi (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Aug 2008 03:44:38 -0400
Received: from buffy.firmix.at (gate.firmix.at [80.109.18.208])
	by ns.firmix.at (8.14.1/8.14.1) with ESMTP id m7Q7iRIv001350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Tue, 26 Aug 2008 09:44:28 +0200
Received: from [10.0.0.138] (spike.firmix.at [10.0.0.138])
	(authenticated bits=0)
	by buffy.firmix.at (8.13.1/8.13.1) with ESMTP id m7Q7iR7f025538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Tue, 26 Aug 2008 09:44:27 +0200
In-Reply-To: <1219700019-19627-1-git-send-email-alexander.shishckin@gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse development list <linux-sparse@vger.kernel.org>


On Tue, 2008-08-26 at 00:33 +0300, Alexander Shishkin wrote:
> I have a situation here when $(CC) is called with -M options with
> slighly different set of -I/-D/etc arguments, which causes all sorts of

I (obviously) don't know any details about your situation but do you
have any specific reason that you have different sets of -I/-D
parameters on dependency generation and the real compile run?

Personally I see only subtle problems on the horizon with such a
situation.
Let alone that it is somewhat simpler to have *one* CFLAGS/CPPFLAGS/...
variable and use that everywhere.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


