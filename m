From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v6 4/25] compiler-gcc{3,4}.h: Use GCC_VERSION macro
Date: Mon, 01 Oct 2012 15:43:31 -0500
Message-ID: <506A0073.9090605@att.net>
References: <1348797281-25021-1-git-send-email-daniel.santos@pobox.com> <1348797281-25021-5-git-send-email-daniel.santos@pobox.com> <20121001123944.e06379db.akpm@linux-foundation.org> <20121001203224.GB8478@jtriplet-mobl1>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121001203224.GB8478@jtriplet-mobl1>
Sender: linux-doc-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Santos <daniel.santos@pobox.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>, Andi Kleen <ak@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, David Woodhouse <David.Woodhouse@intel.com>, Don Zickus <dzickus@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-sparse@vger.kernel.org

On 10/01/2012 03:32 PM, Josh Triplett wrote:
> On Mon, Oct 01, 2012 at 12:39:44PM -0700, Andrew Morton wrote:
>> Is this correct (and clear)?  I'd expect
>>
>> 	#if GCC_VERSION > 40000
> GCC_VERSION >= 40100, actually; __GNUC_MINOR__ > 0 implies
> __GNUC_MINOR__ >= 1, whereas the version you wrote would accept 4.0.1.
>
> - Josh Triplett
Yeah, and now I have two threads for the same set of patches, sorry. :(

Daniel
