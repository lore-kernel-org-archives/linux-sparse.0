From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Makefile: warn user when libxml and/or libgtk2 are not available
Date: Thu, 3 Mar 2011 14:52:25 -0800
Message-ID: <AANLkTiktoPx77xUo5tJR96zYECWFQnazRVary3joCekE@mail.gmail.com>
References: <201103030957.59003.f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64675 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759020Ab1CCWw0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Mar 2011 17:52:26 -0500
Received: by iyb26 with SMTP id 26so1390573iyb.19
        for <linux-sparse@vger.kernel.org>; Thu, 03 Mar 2011 14:52:26 -0800 (PST)
In-Reply-To: <201103030957.59003.f.fainelli@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Mar 3, 2011 at 12:57 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
>
> Since sparse's c2xml is not always packaged by modern distributions, it can be
> built as a host package in build systems, finding out why c2xml was not
> compiled turned out to be easier if a warning was emitted, add two for libxml
> and libgtk2 presence/absence.

The change looks good. How about using $(warning ...) instead of $(info ..)?

Chris
