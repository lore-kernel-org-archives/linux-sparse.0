From: josh@joshtriplett.org
Subject: Re: [PATCH 0/7] Silence even more W=2 warnings
Date: Fri, 26 Sep 2014 12:58:03 -0700
Message-ID: <20140926195803.GB19952@cloud>
References: <20140922184049.GB4709@pd.tnic>
 <3199350A-89CE-4BE7-8FE4-CA8CE4F87622@intel.com>
 <20140922192152.GD4709@pd.tnic>
 <1411415057.2513.8.camel@jtkirshe-mobl.jf.intel.com>
 <20140922195737.GE4709@pd.tnic>
 <1411416573.2513.19.camel@jtkirshe-mobl.jf.intel.com>
 <20140922203336.GF4709@pd.tnic>
 <1411420912.2513.32.camel@jtkirshe-mobl.jf.intel.com>
 <CAMuHMdU7VO01_qRGc0TV2K+nJJCu4sm0zbH773_zBWdaxSR1aQ@mail.gmail.com>
 <4C887554-FB5F-4634-ABE6-20F41583ABA2@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35126 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208AbaIZT6K (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Sep 2014 15:58:10 -0400
Content-Disposition: inline
In-Reply-To: <4C887554-FB5F-4634-ABE6-20F41583ABA2@intel.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Rustad, Mark D" <mark.d.rustad@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>, Borislav Petkov <bp@alien8.de>, "sparse@chrisli.org" <sparse@chrisli.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Sep 26, 2014 at 07:37:19PM +0000, Rustad, Mark D wrote:
> Most of the others come from null-entry table initializations, i.e. {
> 0 }, which give missing field initializer warnings.

I'd suggest that such initializers should just be {}, not { 0 }, and we
should teach compilers to specifically *not* complain about empty
initializers even when otherwise complaining about missing fields.
Initializing a structure to 0 is completely sensible.

- Josh Triplett
