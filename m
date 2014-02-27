From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2] sparse: Allow override of sizeof(bool) warning
Date: Thu, 27 Feb 2014 07:48:35 -0800
Message-ID: <530F5E53.5070208@zytor.com>
References: <530E8C2E.7080307@zytor.com> <1393466619.24588.65.camel@joe-AO722> <20140227022857.GC23659@thin> <1393469594.24588.71.camel@joe-AO722> <20140227025845.GA25145@thin> <530EB103.5070406@zytor.com> <1393472326.24588.82.camel@joe-AO722> <60797a1a-1a83-468e-9629-abf4e8712d65@email.android.com> <20140227082529.GA18210@pd.tnic> <dbc47544-a6f6-4ab4-80b0-25d93a1666e2@email.android.com> <20140227152435.GA7982@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140227152435.GA7982@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, Borislav Petkov <bp@alien8.de>, Joe Perches <joe@perches.com>, Ben Pfaff <blp@nicira.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On 02/27/2014 07:24 AM, Theodore Ts'o wrote:
> On Thu, Feb 27, 2014 at 07:10:25AM -0800, H. Peter Anvin wrote:
>> Keep in mind, too, that for the kernel we don't care about the full
>> C standard but a subset.  We rely on extrastandard behavior all over
>> the place.  For all ABIs supported by the kernel, sizeof(_Book) == 1
>> and so everything is sane.
> 
> Do we have a fairly comprehensive list of what these extrastandard
> requirements / assumptions are?  It might be a good idea to have one
> that we can point to, so that (a) people who are trying to define a
> new architecture knows what they need to handle, (b) and so we can
> give a list of things that static code analyzers like smatch and
> coverity and sparse should be able to suppress (perhaps in a Linux
> kernel-only mode).
> 

No, but I think we can certainly make a list... a lot of it right now
sits in various people's heads.

Here are a couple:

- Bytes are 8 bits
- Signed integers will be 2's complement
- sizeof char, short, int, long, and long long will be 1, 2, 4, 4, 8 or
  1, 2, 4, 8, 8 on 32- and 64-bit processors, respectively.
- sizeof(long) == sizeof(void *)
- NULL is represented by all zero
- Structures will not add padding as long as all the members are
  naturally aligned.

Someone want to set up a collaborative document of some kind and collect
more?

	-hpa
