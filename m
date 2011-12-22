From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 2/3] sparse, llvm: Add test case for <stdbool.h> type
Date: Thu, 22 Dec 2011 07:53:26 +0200
Message-ID: <1324533207.1428.318.camel@jaguar>
References: <1324459528-9344-1-git-send-email-penberg@kernel.org>
	 <1324459528-9344-2-git-send-email-penberg@kernel.org>
	 <20111221095810.GA27308@leaf>
	 <CAOJsxLEOy+=xYUTieDpx6=GLUUXpCW0tv4g_Xd0Ow_qz3D7a6Q@mail.gmail.com>
	 <CANeU7QmBSjM+d3atTakQpUPKLY7hmRxfH044uAigMF8GevaAjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:34250 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab1LVFx3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Dec 2011 00:53:29 -0500
In-Reply-To: <CANeU7QmBSjM+d3atTakQpUPKLY7hmRxfH044uAigMF8GevaAjg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Dec 21, 2011 at 11:58 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> >> Do we want tests that depend on system header files?

On Wed, Dec 21, 2011 at 2:18 AM, Pekka Enberg <penberg@kernel.org> wrote:
> > I changed it to use _Bool instead. Thanks!

On Wed, 2011-12-21 at 16:23 -0800, Christopher Li wrote:
> This series looks great to me.

The patches are in master branch of:

  git://github.com/penberg/sparse-llvm.git

