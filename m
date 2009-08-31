From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: sparse segv with simple test
Date: Mon, 31 Aug 2009 21:04:54 +0200
Message-ID: <200908312104.54990.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <200908312012.37019.kdudka@redhat.com> <20090831114900.6887df23@nehalam>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52748 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbZHaTGo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 31 Aug 2009 15:06:44 -0400
In-Reply-To: <20090831114900.6887df23@nehalam>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Monday 31 of August 2009 20:49:00 Stephen Hemminger wrote:
> > But it might be good idea to implement such out-of-range detection ;-)
>
> Yes, I was looking to use more enum's in places where int was used in the
> kernel. There were places where the interface expected a limit range of
> values like network device transmit, but the interface was being misused
> and caller was returning errno values.

Generally you can't simply check if the value is in a *range* since the enum 
values could be non-continuous. You need to check for all continuous 
sub-ranges or even for all values.

What about issuing a warning for any assignment of int value to enum? (as it 
is already checked by a C++ compiler) Such places are IMHO always suspicious. 
If you know what you are doing you can still cast it explicitly to avoid such 
warning.

Kamil
