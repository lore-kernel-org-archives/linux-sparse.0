From: Ludovic Brenta <ludovic@ludovic-brenta.org>
Subject: Re: sparse and multiarch include paths
Date: Thu, 25 Aug 2011 00:43:37 +0200
Message-ID: <87zkiy1ld2.fsf@ludovic-brenta.org>
References: <20110824214244.GA12248@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay03ant.iops.be ([212.53.5.218]:48290 "EHLO
	relay03ant.iops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab1HXWuF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Aug 2011 18:50:05 -0400
In-Reply-To: <20110824214244.GA12248@leaf> (Josh Triplett's message of "Wed,
	24 Aug 2011 14:42:46 -0700")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org, debian-gcc@lists.debian.org, multiarch-devel@lists.alioth.debian.org

Josh Triplett <josh@joshtriplett.org> writes:
> When trying to use sparse on some low-level userspace code, I ran into
> the following error:
>
> /usr/include/bits/socket.h:381:11: error: unable to open 'asm/socket.h'

See http://bugs.debian.org/638418

Hope this helps

-- 
Ludovic Brenta.
