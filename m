From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v11 00/13] Intel SGX1 support
Date: Tue, 11 Dec 2018 10:10:38 -0800
Message-ID: <12301623-0a63-10ac-1d5e-828569a953e5@intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180612105011.GA26931@amd> <20180619145943.GC8034@linux.intel.com>
 <20180619200414.GA3143@amd> <20180619214833.GA5873@localhost>
 <20181209200600.GA11608@amd> <20181210074717.GA9880@localhost>
 <20181210082704.GA14594@amd> <20181210231159.GA10718@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210231159.GA10718@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, Pavel Machek <pavel@ucw.cz>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org, platform-driver-x86@vger.kernel.org, sean.j.christopherson@intel.com, nhorman@redhat.com, npmccallum@redhat.com, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw@amazon.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>, Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-sparse@vger.kernel.org

On 12/10/18 3:12 PM, Josh Triplett wrote:
>> Or maybe even python/shell scripts? It looked to me like virtual
>> memory will be "interesting" for enclaves.
> Memory management doesn't seem that hard to deal with.

The problems are:

1. SGX enclave memory (EPC) is statically allocated at boot and can't
   grow or shrink
2. EPC is much smaller than regular RAM
3. The core VM has no comprehension of EPC use, thus can not help
   with its algorithms, like the LRU
4. The SGX driver implements its own VM which is substantially simpler
   than the core VM, but less feature-rich, fast, or scalable
