From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: more "unreplaced symbol" warnings
Date: Tue, 31 May 2011 19:30:30 +0100
Message-ID: <20110531183030.GM11521@ZenIV.linux.org.uk>
References: <20110529145450.8c042971.rdunlap@xenotime.net>
 <BANLkTi=_0Xe8Fuq9aJ69Zqx3iQYq6E9N5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:56662 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab1EaSaf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 31 May 2011 14:30:35 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=_0Xe8Fuq9aJ69Zqx3iQYq6E9N5w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

On Tue, May 31, 2011 at 10:39:52AM -0700, Christopher Li wrote:
> On Sun, May 29, 2011 at 2:54 PM, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > I see that there was a short thread in Feb. 2008 about unreplaced symbols.
> > Here are more warnings from Linux 2.6.39-git18 mainline.
> > Obviously lots of them are just repeats, but this is what I get from x86_64
> > allmodconfig.
> >
> > Any suggestions about how to eliminate them?
> > Thanks.
> >
> > include/linux/swab.h:51:16: warning: unreplaced symbol 'val'
> > include/linux/swab.h:51:16: warning: unreplaced symbol 'val'
> 
> I am trying to produce those now. If you know  which C file causing
> this warning would be great.
> 
> It just hit me that, if there is a script to help reproduce the error
> would be great. I just give this error line it emits. The script takes the
> C source file and try to eliminate as much lines as possible while
> still reproduce the error.

Hell knows...  net/bridge/br_netfilter.c will give you just that.  From the
look of other similar instances, I suspect that it's handling of case ...:
somewhere:

static inline unsigned int nf_bridge_encap_header_len(const struct sk_buff *skb)
{
        switch (skb->protocol) {
        case __cpu_to_be16(ETH_P_8021Q):
                return VLAN_HLEN;
        case __cpu_to_be16(ETH_P_PPP_SES):
                return PPPOE_SES_HLEN;
        default:
                return 0;
        }
}

also warns the same way on both __cpu_to_be16()...
