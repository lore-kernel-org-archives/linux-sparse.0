From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/7] pull: make smatch scan output easy to digest
Date: Sat, 25 Feb 2017 23:09:13 +0300
Message-ID: <20170225195901.GB4570@mwanda>
References: <20170213220641.1395-1-kerolasa@iki.fi>
 <20170220121426.5mr6ab6x7pxt5j4b@ws.net.home>
 <CAG27Bk2ENHD+1_sX0qVmVnKC2Ss7jDxSyqhNnaj6NKHNnitsYQ@mail.gmail.com>
 <20170221095012.txqxcblrqkmoxktw@ws.net.home>
 <20170223153049.GC4133@mwanda>
 <alpine.LNX.2.20.1702251653080.16457@imuri>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.20.1702251653080.16457@imuri>
Sender: util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sami Kerola <kerolasa-X3B1VOXEql0@public.gmane.org>
Cc: Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, util-linux <util-linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org

On Sat, Feb 25, 2017 at 05:32:23PM +0000, Sami Kerola wrote:
> See below simple source file that demonstrates how to triggers warning in 
> question. When I said was 'smatch' printed warnings it was cgcc that was 
> complaining , and therefore this is not really a 'smatch' problem at all. 
> Sorry about giving wrong impression.

cgcc is just a shell script which calls either smatch or sparse.  Smatch
uses sparse as a parser so you sometimes do see certain sparse messages
when you run smatch, but I don't do bug fixes for those normally.  You
would think I would understand sparse really well because I use it so
much but actually hacking sparse makes me realize I'm kind of dumb.  ;P

regards,
dan carpenter

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
