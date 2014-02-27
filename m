From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2] sparse: Allow override of sizeof(bool) warning
Date: Thu, 27 Feb 2014 08:52:19 -0800
Message-ID: <530F6D43.5020006@zytor.com>
References: <20140227022857.GC23659@thin> <1393469594.24588.71.camel@joe-AO722> <20140227025845.GA25145@thin> <530EB103.5070406@zytor.com> <1393472326.24588.82.camel@joe-AO722> <60797a1a-1a83-468e-9629-abf4e8712d65@email.android.com> <20140227082529.GA18210@pd.tnic> <dbc47544-a6f6-4ab4-80b0-25d93a1666e2@email.android.com> <20140227152435.GA7982@thunk.org> <530F5E53.5070208@zytor.com> <20140227161004.GT26722@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57375 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbaB0QxW (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 27 Feb 2014 11:53:22 -0500
In-Reply-To: <20140227161004.GT26722@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Borislav Petkov <bp@alien8.de>, Joe Perches <joe@perches.com>, Ben Pfaff <blp@nicira.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>

On 02/27/2014 08:10 AM, Dan Carpenter wrote:
> 
> That last assumption has to change for the Meta architecture.
> 
> https://lwn.net/Articles/522188/
> 
> On meta, the structs and unions are padded to 4 bytes unless they are
> explicitly marked as __packed.
> 

One have to wonder how likely they are to have that not continually break...

	-hpa


