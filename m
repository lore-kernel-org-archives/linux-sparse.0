From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/7] Silence even more W=2 warnings
Date: Tue, 23 Sep 2014 12:04:24 -0700
Message-ID: <1411499064.29268.6.camel@joe-AO725>
References: <20140922184049.GB4709@pd.tnic>
	 <3199350A-89CE-4BE7-8FE4-CA8CE4F87622@intel.com>
	 <20140922192152.GD4709@pd.tnic>
	 <1411415057.2513.8.camel@jtkirshe-mobl.jf.intel.com>
	 <20140922195737.GE4709@pd.tnic>
	 <1411416573.2513.19.camel@jtkirshe-mobl.jf.intel.com>
	 <20140922203336.GF4709@pd.tnic>
	 <A05C31E6-7AD2-482A-B590-A5ED57D028B3@intel.com>
	 <20140923082209.GB22072@pd.tnic>
	 <029E2CFB-C001-4E16-B1F7-A3FB193E3138@intel.com>
	 <20140923184456.GA16467@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140923184456.GA16467@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rustad, Mark D" <mark.d.rustad@intel.com>, "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>, "sparse@chrisli.org" <sparse@chrisli.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, 2014-09-23 at 20:44 +0200, Borislav Petkov wrote:
> On Tue, Sep 23, 2014 at 05:24:22PM +0000, Rustad, Mark D wrote:
> > Perhaps checkpatch would be a better gatekeeper for new code. OTOH,
> > some of those nested externs have already been eliminated, so at
> > least for now the warning is serving a purpose since it is scrubbing
> > existing code.
> 
> Yep, eliminating would be optimal. If it is in checkpatch, it is much
> easier to manage.

checkpatch is simply a regex tester, so it's only appropriate
if the false-positive false-negative rate is acceptable.

Coccinelle may be better at whatever test is being considered.
